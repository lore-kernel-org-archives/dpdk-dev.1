Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D026DCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 17:33:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FB1A40268;
	Wed,  7 Oct 2026 19:33:57 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id CE87540265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 19:33:56 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-88834d30002so1122980b3a.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791394436;
 x=1791999236; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4z0LFbB0xjcC66lvg+OuG8erg/EK5qUF0/keni8HtSY=;
 b=p7UTJsJbiDJW8XRHy2xYXRyWaeH1cvP6aXydOfBAex8XaVo32e7HAPENpCoe90Or/+
 XEBKMFF/qBLFpf5mXoHbQu+eKTzO5o6GthZcKpsxgKs3RDa0iE9nfsV16Yo0C9/asZ7Q
 Eav1CTI7X/6d5eeH/hAFNugrKjILuVc5kFYqoVHCQX7s0djsTvOFiJB2PfxmG9T+ugfg
 jswbhE9X2sGKuwtp/bpEaiwQ9sddWoIT9HdYw2mzzb1n02wtJOAROqykx/sIH1xJGsab
 gcI0Hwwr1J0O88GK2Cq1AO2QJI7eWMEaHG3iWycOZb0ILwx76yo5awgY+lsQsbpres2t
 NnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394436; x=1791999236;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4z0LFbB0xjcC66lvg+OuG8erg/EK5qUF0/keni8HtSY=;
 b=1EegRY6u17c4qrxU5dmMarIFeaCHoGZSdvRQoj8zXcrLGt5p3ax9J5pve0T75+vM21
 UQRrtrwDO1aPuXq54LNPpyhhLgV6h9ff3F96cXMmzTZG9AFXwEeRtVSO8NO+6CSB+lML
 X3jT5R5+9mV2hB3/8rgj9hYaRh80MPCBDSmiB7s6kMuF4ejKLfyzRKovil2BnkJGLYvu
 vdfxhxB+xEBBBI/VrG+qwcXfsZwLXSotRPTEClJt88P3DXaQKCiCx++TTHCO0h+3bESh
 zoGDzgeiXDRKzy2Tos/5GwSgepLtKdD8FI5xmB/RlrTLYbK0c1WHqCPpG/9l64fDl/bE
 2Aow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwceFR6olSvGPLhNzjLjQZpELVlasJoWxpjzgN4m8HySvF3kbKYKo4lzA27tvUi07E55wk=@dpdk.org
X-Gm-Message-State: AFuF++lxjvL1q2QksJ/LO7IfXTJS0XcPw4sVX5X6h37jivMMquWFSwgQ
 b7I9t84DbmxZC25kDwU0+qjVAF0AMkxfo00vW/OJBtHsElThRA7kac+IvFhfma6Ssbw=
X-Gm-Gg: AYBFou3QzQU9NDn8uOPdZ8Hi0WADK062UIk/Aksn2xQkOmHvJdw5CZ/XF/wsLc4Hkcf
 dH5iCeLamPYMUORXiDdcVismLftk8LgWreSyfsKJBLjI6SSL/IqzkOWOu3MwpaJ1hHHdnSHcTzi
 OsDlF4S83ciA3Eoorw0BPRl9351ryDc5dbgB9b7Q1okv7DKF15tlAOLa69pQ4dtZpvaadoSbpVp
 18QuJED2FLSbCzLAn6ffFGaEN4fw7NpSx2Fq3F/kGAev/j4nxRUlm6rhX9KmF+tr8JLCCShRT36
 ALPE1yKsBpcZcuxeRxqdpIdLM8F0lcDucfyFxn2yfsKt535FVAMm3wUThzyA16GBtI7T+PA9pEg
 PxQoT1Jg3TLqRZHZTw3QGooNlJvyQjcme5ZHfCAD43HOsj2JN7ajJEGXmGdZAvBbcYSRVRpvmqw
 kOABRCRAdpqRipuJnjKj0N4d36Q/NjiPKTPgZF+/oXlefTbfnG9RZLYLz5GKgCIexHLbo7oxwvc
 Nm+WMSqkPJHFwaqz+KrNfGX9rFhB//IrpFKUSeQgQYnWllrvoU=
X-Received: by 2002:a05:6a00:408c:b0:887:3fca:8330 with SMTP id
 d2e1a72fcca58-891b1d75d2cmr2294772b3a.46.1791394435669; 
 Wed, 07 Oct 2026 10:33:55 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-892bbd8823bsm663511b3a.51.2026.10.07.10.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:33:54 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:33:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Message-ID: <20261007103350.3be6cd09@phoenix.local>
In-Reply-To: <PA1PR04MB10770B9B7A3839B5F6EC7BA0F89942@PA1PR04MB10770.eurprd04.prod.outlook.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261006080145.33d89b9b@phoenix.local>
 <GV1PR04MB10750BE973E9EC07CE3A70D5B89942@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <20261007082642.24b92b4d@phoenix.local>
 <PA1PR04MB10770B9B7A3839B5F6EC7BA0F89942@PA1PR04MB10770.eurprd04.prod.outlook.com>
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

On Wed, 7 Oct 2026 16:28:54 +0000
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> On 07-10-2026 20:56, Stephen Hemminger wrote:
> > On Wed, 7 Oct 2026 07:24:37 +0000
> > Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> >   
> >> On 06-10-2026 20:31, Stephen Hemminger wrote:  
> >>> On Tue,  6 Oct 2026 14:56:36 +0530
> >>> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> >>>      
> >>>> This series collects a set of fixes and enhancements for the NXP DPAA
> >>>> bus, mempool, dma, crypto and net drivers targeting 26.11.
> >>>>
> >>>> It includes memory-leak and resource-cleanup fixes on the device
> >>>> remove/close paths, more robust frame queue and congestion-group
> >>>> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> >>>> handling, and several new features: offline (O/H) port device support,
> >>>> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> >>>> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> >>>> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> >>>> errata-workaround devargs. Documentation and release notes are updated
> >>>> accordingly.
> >>>>
> >>>> v21:  
> >>
> >> It is becoming a never ending cycles.  Every time we fix, it finds new issues. Can we put a limit to accept it with no errors and minimal warnings?
> >> I am anyway fixing the following and sending v22.  
> > 
> > I won't accept patches with errors or warnings, sorry.
> > You can run the same reviews locally.
> >   
> 
> Ok. I respect that.  Please check V22. If there are still warnings. 
> Will you please let me know what all you are running for review. I will try the same locally. 

I use claude with either web gui or desktop app mostly. And the AGENTS.md that is updated
by this patch set. Claude is smart enough to read local files. Usually I format up a patch series mbox
with cover letter and attach that. Though when using CLI you can ask it to look at commits directly.

The changes in this patch are mostly about getting CI version to not give low confidence feedback.
https://patchwork.dpdk.org/project/dpdk/list/?series=39179
