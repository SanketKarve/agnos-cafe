import React, { useEffect } from "react"
import { useRouter } from "next/router"
import type { AppProps } from 'next/app'
import { getUser } from '../utils/storage'
import '../styles/globals.css'

const styles = {
  root: {
    padding: '5%'
  }
}

export default function App({ Component, pageProps }: AppProps) {
   const router = useRouter()

  useEffect(() => {
    const user = getUser()
    if(user !== null){
      router.push(router.asPath)
    }else {
      router.push('/')
    }
  }, [])

  return <div style={styles.root}>
    <Component {...pageProps} />
    </div>
}
