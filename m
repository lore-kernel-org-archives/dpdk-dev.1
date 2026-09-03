Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4601CC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 18:19:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8524026C;
	Thu,  3 Sep 2026 20:19:50 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5212C40144
 for <dev@dpdk.org>; Thu,  3 Sep 2026 20:19:49 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so184130a12.0
 for <dev@dpdk.org>; Thu, 03 Sep 2026 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788459588;
 x=1789064388; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z6qO2FfGgGr9+6xSCGGPqatVlSscs5NFUbaMflULE9g=;
 b=ZM+NUcbou/awwfY6MoZqmeoJabRdwtb/QlVK1QKotk16+gInsg5+DmEDBFLwJfX7YR
 1VxiTt8RKDWuSJMmsVpndXv4JtME2My+etrSR4+31JAL3K7Q39bYO0QTTlHvgr9i0uZj
 fv7aolFVMkgBydFMpeFgunIZKfrVS/Ym/Bhq/sTAbkPzQW6+MIGjvGgXOfRdXa3fuHAh
 DRpgoS9j3LIw58LXpyILJbdY2LeefXrwrWhJxK2cJL8jK7WnGj+g8ETEedPX8VQx9oTa
 BSLYb1zbfSOzCVlA4ulCpXVK4KgSY2PoeAc8+tTLTlawgy29opEDB/BvVyPZ3g+/XjuY
 Gvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788459588; x=1789064388;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z6qO2FfGgGr9+6xSCGGPqatVlSscs5NFUbaMflULE9g=;
 b=qikpn6WypXkv5wsJZiv4gu81AFq1TrBNOSF8F1y6jvTBnH70TfgIlVF5aVqgxUa9Xx
 Rx15xfRPyUsTh/dAmaZ6bp7rRB6+RJJsjLyghufwmbrBxEVGe5OMEsnzyYvW5cl5kv7w
 2QYrYhrZDhIsvag+lwN8jYiowiqMDjv0z7Ru9ahjcNCqzP9vtKBW22f7eZM5ZaG0279w
 w9aV9qqI68p/YogKI+w6pXZD+hFPi8WFKw86X5YPoYKGQOHIvr2lvwF70rek7PhUFRg/
 wyDW1TfkK6sgohdphwBhE0LHCKiXRutjIZ236Snb/WniK7CNuu6aEtVFpkcWBf3Sst9y
 JDpQ==
X-Gm-Message-State: AFuF++nJshzlgy7zksmVXZMeWXAO8aXGs4cy+ZNnVrQ2PBdmBeoTpQR8
 LNpB20EiYZsTr1FoHq7sh+UrO3U1DewwlRqgRax5VPjCnK7slkjbWG2fDPz9TEs7MLU=
X-Gm-Gg: AYBFou1ndGn1PvRHPG8YoSjd75TO9SpaAg5VV+2y6tVPDSVFeqf23On+NfldZ4T146H
 Ov2ZZFVpjr2ukq42XrggaXGEFpV/ebZt/1XJIXUlQ7psaLnS6aDCuf7H6Uxx9kw/WSLW8Kgjk5Z
 Wrc/ZGiYbI6dxGFKAQP8tdr/2MNwf8aWXU15XFCA5wxgGGbjo7hOEUiHcAn5GZjFcwYl4tWwrUD
 cP6q8sZxDHdN3z6o0rT6J5GNkuQkt7Fxot39mcwOh1eDuyf2uUSZtsELjl3DytjfWX9eDCW+h0D
 D52tspnZDVFzbBYJ3F4ct6O04Pb6CNXdJcT12+wBQAf30GGslqOHygeaq34Jo4W7kO8lCHEXZY8
 YihxBLCTOwjYalvVpVLGKfaXvSnv1NbSQSpfM08pW9AvoDpAh4SCcol/LNTxs2hByvVyOfk/oWl
 0/JbPXthaw5Y+Gxdu4UIY9DvKL9iPiUXhC4fP/ZeCTunF3w0y/2fR0cUVaMHLkuSAD5jr955qaz
 gXHJPRe/MzOu03AxjXe+DXkBMsBuw==
X-Received: by 2002:a17:90b:1643:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-39b26272f04mr435728a91.14.1788459588198; 
 Thu, 03 Sep 2026 11:19:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcc060sm7635605a91.3.2026.09.03.11.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:19:47 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:19:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v12 15/15] net/enetc4: add WRR Tx scheduler devarg for
 VF rings
Message-ID: <20260903111938.6164ae05@phoenix.local>
In-Reply-To: <20260821055643.1359277-16-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
 <20260821055643.1359277-16-g.singh@nxp.com>
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

On Fri, 21 Aug 2026 11:26:43 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> Add enetc4_txq_wrr devarg to configure per-ring WRR weights in the
> NETC LEAF-level Tx scheduler (TBaMR register, bits [6:4]).
> 
> The NETC Tx scheduler has three levels:
>   - ROOT (port/TC): strict priority + CBS (PF/port space)
>   - MID  (SI/VSI):  WBFS shaping (PF space)
>   - LEAF (Tx BDR):  strict priority + frame-based WRR (VF/SI space)
> 
> TBaMR is in the VF own SI space, so no Linux PF involvement is
> needed for PRIO or WRR configuration.
> 
> Changes:
> - enetc_hw.h: add ENETC_TBMR_WRR_MASK, ENETC_TBMR_WRR(n) macros for
>   TBaMR bits [6:4], and ENETC_TBMR_PRIO_MASK for bits [2:0]
> - enetc.h: add txq_wrr pointer to enetc_eth_hw struct
> - enetc4_ethdev.c: add parse_txq_wrr() and wire ENETC4_TXQ_WRR devarg
>   through enetc4_get_devargs() and enetc4_dev_configure(); apply WRR
>   bits in enetc4_tx_queue_setup() and enetc4_tx_queue_start()
> 
> Usage:
>   # strict priority: ring 0 highest
>   -a 0002:00:12.0,enetc4_txq_prior="3|2|1"
> 
>   # WRR 2:4:1 on same-priority rings
>   -a 0002:00:12.0,enetc4_txq_prior="1|1|1",enetc4_txq_wrr="2|4|1"
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---

This is in next-net now as is, but you should fix the arg parsing
code not to use unsafe string handling functions. 

strtok() is not thread safe, use strtok_r() or other non-destructive parsing.
atoi() and atof() except garbage and don't do out of range testing and take negative values;
use strtoul() here instead. Probably should have a DPDK string function for this
like rte_str_to_u32() etc; might get to doing that.

Newer version of checkpatch (in python) flags this as:

### [PATCH] net/enetc4: add WRR Tx scheduler devarg for VF rings

ERROR: [FORBIDDEN_TOKEN] Using strtok(), prefer strtok_r() (non-reentrant static state)
#  drivers/net/enetc/enetc4_ethdev.c:76:
+  		str = strtok(NULL, "|");

ERROR: [FORBIDDEN_TOKEN] Using strtok(), prefer strtok_r() (non-reentrant static state)
#  drivers/net/enetc/enetc4_ethdev.c:107:
+  	str = strtok(input_str, "|");

WARNING: [FORBIDDEN_TOKEN] Using atoi()/atol()/atof(), prefer strtol()/strtoul() with errno and endptr checks
#  drivers/net/enetc/enetc4_ethdev.c:75:
+  		hw->txq_prior[i++] = atoi(str) & ENETC_TBMR_PRIO_MASK;

WARNING: [FORBIDDEN_TOKEN] Using atoi()/atol()/atof(), prefer strtol()/strtoul() with errno and endptr checks
#  drivers/net/enetc/enetc4_ethdev.c:109:
+  		w = atoi(str);

total: 2 errors, 2 warnings, 0 checks, 102 lines checked
