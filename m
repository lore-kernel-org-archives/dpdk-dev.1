Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B2CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 17:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55B2040291;
	Fri, 16 Oct 2026 19:04:49 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 465334026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:04:48 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e5378b281aso164725ad.2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792170287;
 x=1792775087; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YGpgloFQr+KfVxvRxlBN/geYvaDEXkkQcvTSqYbDbfA=;
 b=ZTyHn5uOwT/z8vkkXZF8qlG7jvTIYTmFho2P1Uo2kTp0IL+SssmpyKx1jP8zvcmCrX
 gLPFk+iU2yxxf5DkcjOba20FuGb3yftZzPEQ9O+6TuNg2qUTuLqLuGH3/LFtxTM45b5B
 +2LFLuqXBv8pcAmeCRw9yOkFTo6klD0TKquN1J1rt3rX2M1mL35va5RcM6ZULCFBbscU
 hcsLXgtGYi7HrR9IKYBNCbVOygRcOmiBMwpIHbqToigZGgrq7PamvIC6ZyDItka+lEJ7
 4TuG/tIcRVezxNq7tF0YEJegP17hLjQj+n1xnE3lzBtDqr2K8d7ClxoB7XIROSfeBQ/f
 Uhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792170287; x=1792775087;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YGpgloFQr+KfVxvRxlBN/geYvaDEXkkQcvTSqYbDbfA=;
 b=VfAm6hT7Hxn+6UD7JDhTtEMDkOY1U3LZG7hYXHH3cXET5tbsLEXQLOzW2gsCNjGt1F
 SQab5dWwKW0yM+v0LWocN5iv1yCBQmvpRYZ0bACXA6EpKnRg9u2R7yv7JDybJjXqeEkm
 rRLPVJiWJI8z5sQCpaHGIrfhxELsrWC46vxdwHRQ9zmotcvfKEchJ3t/0jSzWWQSHmWQ
 IEckDrzc0h+ssOcsa7qkyFh14Il6R9U0mh0vrekYM9BhGiPtov/nkNSjfeNPpL0nhENR
 xKJXvRz/ItGdVSe9IFaTFx9Z3EgfMnXQZdlNTmnLtxPgPR0PiKLLImGhn+mXFEg9L3UI
 oqSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJ5f8V60Hi6tydhBIQ9Lj5Vfm4Hhc+n3m4jwQGDz0r+WVXCwx3zDujuqb0iq1ron064nU=@dpdk.org
X-Gm-Message-State: AFq9FYKayKlYHczZww9SwTr32IvyWIAcLXeFyZ0scRxbtSQ1AVP37EW7
 8imoPkqJ4B4Y7h8V9ZrHfeGwkUtc8023d6PFMhIgwV3q72bf9DWyHjBjL1oXufJqn38=
X-Gm-Gg: AYBFou23SXO6N2uSW8/hBUIcHgy0hgjdPPSjp27HZxmHj5hScw7EoLIi5HSkYGCauTX
 XsSNfI2VzxUgFzRWjhwrAAh8XQ2Yl2Qiy5R7ESz5bFhPOtDF0N9TFVodGQtqNJTX5w6/3XTeQLW
 pXWmg7v7rk5n0hHVPLk+h6AkqdT/HwZMCR7uSWBcsis6btbCsXy/BA7DeNxL50xYcZeS2bg314W
 rCgZUitkSAHvu5cpyUCONRtYCs9VnQCPpJSEvdAE70OB3YKw+zEQfMcxHeY+KTmIaoMzDTPSykq
 g/f1W1c4rF7BXalLQaXKwCzHevHtHsHt3gvrP7eZtIol2UnPDML6ThpUUJii8mj/PcqrFXq03ub
 /GOd/oJsWSmcj1xoZ32ZLfhrJSAc8Aj9Y/4g34qL82ql0NWtUGRSQeMCfXOeGZM4w/V4oRmiZm6
 UkCyPklBRSzsBDoRPhodX9BG5GwjIUJUsR3YGg0PJWpUrBJ5zJFG/SUZUvYZxYc+V/io2Gog5ew
 bThjW+TktIH73Id0CUw625D62ZOvyJM3XdYudgw
X-Received: by 2002:a17:903:b83:b0:2e9:5313:8f76 with SMTP id
 d9443c01a7336-2e9a6c13b56mr5235675ad.47.1792170287227; 
 Fri, 16 Oct 2026 10:04:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e85fd1dsm13506765ad.49.2026.10.16.10.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:04:46 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:04:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Message-ID: <20261016100435.4dc6dc10@phoenix.local>
In-Reply-To: <GV1PR04MB10750670E599D034FA89E627A899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
 <20261016093848.7dbe6c73@phoenix.local>
 <GV1PR04MB10750670E599D034FA89E627A899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
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

On Fri, 16 Oct 2026 16:48:30 +0000
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> Hi Stephan,
> 
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> >  
> 
> NXP Confidential
> > On Fri, 16 Oct 2026 16:49:33 +0530
> > Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> >  
> > > This series collects a set of fixes and enhancements for the NXP DPAA
> > > bus, mempool, dma, crypto and net drivers targeting 26.11.
> > >
> > > It includes memory-leak and resource-cleanup fixes on the device
> > > remove/close paths, more robust frame queue shutdown,
> > > secondary-process safety guards, BPID lifecycle handling, and several new  
> > features:  
> > > enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> > > configuration, non fmX-macY shared Ethernet naming, and DMA
> > > scatter-gather and errata-workaround devargs. Documentation and
> > > release notes are updated accordingly.
> > >
> > > V27:
> > > - fixed qm_channel_pool_num check issue.
> > > - fixed commit message as devarg for fmcless rxq number was removed.
> > > - Added missing export internal symbol and fq destroy.
> > > - merged both FQ shutdown patches as we cannot change the sequence
> > >    because of the dependency.
> > > - mac_idx has a user which is dpaa flow so no change. Added static to
> > >    g_fmc_model and updated release notes.
> > > - Issues reported in v25 which are not handled, were optional, so
> > >    skipping them.  
> >
> >
> > FYI - what I do is feed the patch into a Claude project with existing AGENTS.md
> > file. The chat continues as versions get sent to email so the context window
> > has all the versions of the patch. This lets it see the progress and check if
> > previous findings were addressed.
> >
> > Review of [PATCH v27 00/25] NXP DPAA fixes and enhancements
> >
> > Series applies cleanly to 26.11-rc1 and every commit builds with -
> > Dwerror=true. The fixes are now first. 08 cherry-picks cleanly onto
> > v24.11 and v25.11, and 06 applies there once 01-05 are in.
> >
> > v26 Warnings on 12 (now 14) and 20 are addressed. The 24 Warning is only
> > partly fixed.
> >  
> 
> I see only one warning in this patchset 24/25 -   is it possible that you drop this patch and apply rest of the series?

I could if that is what you want
