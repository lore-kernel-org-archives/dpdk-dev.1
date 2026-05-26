Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC968CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 21:38:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6445B40280;
	Tue, 26 May 2026 23:38:19 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id EC7264021F
 for <dev@dpdk.org>; Tue, 26 May 2026 23:38:17 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso14118354eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779831497;
 x=1780436297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Z+wOdTsZynvWF4ebLQVF5c/XfAYHdydSZDIL7hBNW8=;
 b=uYb+Ar1tLfovf93GAZgSLAeKTD/swtriDz1e5S6sI7NeEzzMOkWrKQEVbZDEhg2JUt
 8s+H4mKKM1ZUKLn2//bYzeH76JfpTvg41RVxNa9H9EuUIfe61/SmQ6OUnqNuotvKB5wX
 TKRh0oUtpUrBeBozRQU3UTvDy+b2SOm8v/LVMXsNfv0qx88kf343djCkHAZYYe/MlWFm
 3HxJSmqkulgYtCe5ssRKA+d2j8Iw2hOgtojty2lVpUudbMmWDiEP54uu2C0CZyeAItyL
 d11qAFZav44wBOQ/xPE1SoT5CZUdZuFhmpoE6KKZnE+w0PTB2kKO8WcQCE0Rx8IqILAd
 4QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779831497; x=1780436297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Z+wOdTsZynvWF4ebLQVF5c/XfAYHdydSZDIL7hBNW8=;
 b=aEGM7lIqWoFvUQIvJMBmahmXNCw8vpZZQ0hh7U9TH3yicvzCgE9z2ra/AkYa2ydjbB
 qkPy1MzFlEDWUsGSZ+xHnznqGZYLuXflW4cVk2DfOXj2qsoAdUPTv+AWxQ2eYKyzxSY2
 hpaVq/VLGNwvD3FB0o2QvfxbSg77u+SjLDpjfMsIkQdAKf6oEeHcXdoiYOLCPdhwpiOr
 tB9iu43Trah7XWdbCbl+hteRbkqCdTbeGwMdpgXRU6rKkh9G9oLxlFebCkSPAcmH8HwM
 jSR1u3Ra86d1pocZsns7DHuQ9ivXz5K/YeARwFbLrRpBuhJrBagO09ITXfSC2ObCEOTA
 bFkQ==
X-Gm-Message-State: AOJu0Ywfpt6Thrl1w/DGNn5RFnE2bSYM5r9c/Qph3hS/IYxmN5oWlX2T
 4m6lA/l4g9cZfyXrMnkeN+5C7dmNI171yedvL4c+4GNfnwbHbAKRJHncdTXhGtiS5lY=
X-Gm-Gg: Acq92OF3kqW7+YCdyycYK9fXQdZl2xY73+2Hy1csi1inR1PYblFfEcqqrUloRmrzjMH
 4HksTGe4Whcv4F8l7ZQabLA2ebEtxhnZOjRF8aiaaGV0aIGXDeW+Pu3dIWvGrL8Xl5eSl1ZJQW+
 K6z1B+yB58rp4r0fhiH+WpDcPJVaJNEBAVbZLokKptxtGIcdfnjThNK/4nkze80E7UQFlp24sk6
 eX5SFCtIbKqu8R1lChlFAtLf//S1wRU2M6RJJNw5L6QLJmQqgpKj/H1IIx+iDfarrvZX+lt2G6u
 OLAVWvccMPfKqzCy0xudqGxkZIFxsl2ddn7sua1yt7DQ4A0UcTIWXnEzTBe0UB8INpN8sQibkkB
 YCuJv1avbuDnfn1WRlVAAUXzQRrzV5gpe0YIUqhF18ylCcxzW6owSnJ/5xD278e660eUOZVL5cR
 zJljP11+2R4svLnci8J2rouZe5+ZxS3UAySDBsJtmWtVHqorhqsXNc9tl0qqefRF1M3nNR4RdBc
 EEGbcHSwwWWNw==
X-Received: by 2002:a05:7300:ef89:b0:2ed:23cd:babf with SMTP id
 5a478bee46e88-304490906d0mr9351706eec.12.1779831496580; 
 Tue, 26 May 2026 14:38:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304524610f7sm11256192eec.29.2026.05.26.14.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:38:16 -0700 (PDT)
Date: Tue, 26 May 2026 14:38:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 14/25] bus: refactor device probe
Message-ID: <20260526143812.2bd42ad1@phoenix.local>
In-Reply-To: <20260526085257.3148516-1-david.marchand@redhat.com>
References: <20260526084212.3145685-1-david.marchand@redhat.com>
 <20260526085257.3148516-1-david.marchand@redhat.com>
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

On Tue, 26 May 2026 10:52:44 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Introduce a new rte_bus_probe_device_t operation with signature
> (struct rte_driver *drv, struct rte_device *dev).
> 
> Replace the existing .plug field in the struct rte_bus with .probe_device.
> 
> Update all in-tree buses to use .probe_device instead of .plug.
> Each bus probe() function now calls rte_bus_find_driver() (which uses the
> match operation added in previous commit) and passes the found driver
> to bus.probe_device(driver, device).
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

FYI - deep dive (more than normal) AI review had these minor
findings. I would ignore it.

That leaves the following items from the full series review:

    Patch 13 style nit: dsa_match in drivers/dma/idxd/idxd_bus.c has return type and brace on the same line, inconsistent with surrounding functions in the file. Info-level.
    Patch 16 (NXP scan init): fslmc process_once = 1 is moved from immediately after the early-return check to the end of the function. If any of the new in-scan init steps fails the function returns 0 early and process_once stays 0, allowing re-scan on the next call. In current EAL flows scan() is called exactly once so this is unreachable. Worth fixing for defensive consistency; not blocking.
