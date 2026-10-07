Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B2CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 15:26:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC7D140274;
	Wed,  7 Oct 2026 17:26:47 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD1740265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 17:26:46 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ccd0887c542so908762a12.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791386806;
 x=1791991606; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=074boyNg2ym4rAnOTkj+E+4PtGCV2jUxq9A+yoYzQ90=;
 b=N592U9vg2G/XL3DC/dJl1+Qazkqyz7IA06xQqnbHdbRaYnofIwo5S4Q+8RpaWrL1QJ
 9R2c/tciMhnbdUtvLVwLm+eT+XH98EJEFRyvWYfD/F6OSOqRePAfHMyYWzdWM1q8gg6b
 nrkDnLMwW53poa0ijKHL+5/ZFxONHU2wgbgWh7zdC8irdjg5TgYZbd1/8PRLIhEuNjv9
 M4A32XiyCrgOrbgt6TsgN4kCRmmePBK/juAEpIzq09DyT3tA17K4xyYdokMWwZAQrob5
 HnaiA5Q+UAALXPUBzD1Tr3D7+Trm9dVpb80MudDZ45zkrvPrXCzzq7bgf4ZOLW9BaFS3
 lFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791386806; x=1791991606;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=074boyNg2ym4rAnOTkj+E+4PtGCV2jUxq9A+yoYzQ90=;
 b=oiS5dAp/nwBD2JKsyltg6E7mCe//6UqKZXLGKZDow7CKrvDH4FmJxLTfq9XGGaDGKw
 WjKBf3JVEDZRfCMVt6ijO+dUmT4UHPwTWxtOVxQX3do45XokyAuvT9lJlDCSak0nvrq+
 euuW3Uk6hltjUncwcNgavSO7Oj3jbTO8tKR0K2p2wfZFkuVGHA3OE7qwcHpxFvVL+K3J
 Fg8P4M/qZ5NL114V6bf5p8Dxqs5ufbeYtsI4b7BJW8/Oum49RcOyXD/ElZhaPhbSnRlK
 me3h/tTrsCxKfIHmA43SHbEsJpaMJTjx3BvE0K1MKaSeLMY17k4t7IYyzEpc9wAMU0bo
 83Wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsP6jB6uwUrZjhIJNYFS94bxLKxtk596/QeM3Fc5hfdKBTWPnir1jH1s/cUzNYeGaznOM=@dpdk.org
X-Gm-Message-State: AFq9FYJwCa0onn8dS1wdPGUojz0eUHcSR0JMwNLNtcCMux010ZUzMB28
 r98CnVbrqLMMFkTysgLs3MlRiFHU8FsfgZJWevwsucy1R89WWG29L6KHHZ7NERJMDIw=
X-Gm-Gg: AYBFou05fC9AyeHc1Z7Y/HXLczEjvBFteSJ95Q/2L+vJwBXyOl9XQqxwYwB0Ea/4mjQ
 gpBeRzDI8ua9oE5fFpPQ0yDXn6+D0jLF6x6ujfI7HFqVPM2YlkkzUzPxcKJa+y5DQAF2lT3zn5C
 lZqMIqCiIorrFdHKonUreqfb7d1JWarRC0v7+6Gqkw3QcxiC17ffVQLsOAjZxJFaFU30dpAVm43
 Nbf7AtBoYzAoLlYxdSxl8rb0FYCz56xi2Ftodx6ixuhceUotCCX+uW5SbK1WAoJKy6xl+7tGpOa
 YJkcqq+KQYcF4FRxUB4rN4L0909P8B9Ft6pegWyomFjvpXQvRu1c/Gakq4KYYe7k9GX5zU7C2uP
 rITXBNx5yl8qJAbu0dXJAwfA+LSvDV7Vpn4vpO0vyluTSW/T7PnUxbmz5/ABLLikjExr5qGswJB
 PtkGRJBHUFDBILfoNxIO3IumBg55ScKiMv9IlI6AgC1K1uq4JEmdcNfgd1Fj+XcNsnnC6410t1d
 Dd4ZRBru3OGfdR+m9y+Mm6JRMJRfwXVVOvyvytXsfazITDEiyI=
X-Received: by 2002:a17:90b:4a0e:b0:3a7:bb1d:3688 with SMTP id
 98e67ed59e1d1-3a8a1ae9228mr2499822a91.27.1791386805406; 
 Wed, 07 Oct 2026 08:26:45 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a85436a39dsm10802659a91.9.2026.10.07.08.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 08:26:45 -0700 (PDT)
Date: Wed, 7 Oct 2026 08:26:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Message-ID: <20261007082642.24b92b4d@phoenix.local>
In-Reply-To: <GV1PR04MB10750BE973E9EC07CE3A70D5B89942@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261006080145.33d89b9b@phoenix.local>
 <GV1PR04MB10750BE973E9EC07CE3A70D5B89942@GV1PR04MB10750.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Wed, 7 Oct 2026 07:24:37 +0000
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> On 06-10-2026 20:31, Stephen Hemminger wrote:
> > On Tue,  6 Oct 2026 14:56:36 +0530
> > Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> >   
> >> This series collects a set of fixes and enhancements for the NXP DPAA
> >> bus, mempool, dma, crypto and net drivers targeting 26.11.
> >>
> >> It includes memory-leak and resource-cleanup fixes on the device
> >> remove/close paths, more robust frame queue and congestion-group
> >> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> >> handling, and several new features: offline (O/H) port device support,
> >> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> >> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> >> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> >> errata-workaround devargs. Documentation and release notes are updated
> >> accordingly.
> >>
> >> v21:  
> 
> It is becoming a never ending cycles.  Every time we fix, it finds new issues. Can we put a limit to accept it with no errors and minimal warnings? 
> I am anyway fixing the following and sending v22. 

I won't accept patches with errors or warnings, sorry.
You can run the same reviews locally.

The other recommendation would be to send smaller shorter series, if you wait
for a whole set of patches there is almost certainly going to be something.
