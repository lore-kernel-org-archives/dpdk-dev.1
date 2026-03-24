Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92199F54AD2
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:12:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84504406B8;
	Tue, 24 Mar 2026 17:12:47 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 5E52F406B6
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:12:46 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12a80c36350so2938357c88.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774368765;
 x=1774973565; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KuKf3bpq1fZ+ETXT6NedDY4Wsv5aHy+RItiPiIV78MQ=;
 b=O1EqoMetXJ5CxcCu/lUhLRjUxew4for2f1P/w1Zj78RFA9JtdsxtikWCJl+8KnhhGk
 ZqTday8RPA2Tqo7OZFTD1eHcl+8Uzr0tHfLO7rxkm23WcO/CTR2FCzWDOna67r7VKT8S
 Kr727bftgKGVlaD3hCwGnDMOZ6HBnz5OnoYXNZUFiYpDvGILd9Txk0tlEHxnRdx/zXJT
 33/0bPM3ZrfPdSJIkHLA6lkpH6DqH/u9ejlYXJnS8VH6DxrFggGPaNMIjUP1FWo93LY/
 +SRreB4K1WEVHdb4XYIvQAvSRsmVt4oCd5k8Do1mvY2i/D590gGmSuuk/e9Bv2oKD9A8
 LD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368765; x=1774973565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KuKf3bpq1fZ+ETXT6NedDY4Wsv5aHy+RItiPiIV78MQ=;
 b=a5jmNNVVWrgD5GvwTS/Z0AxAl/7sV/DQ8FN6HcHbLJz3nNqgy3iPDcp4slhjsMy1BS
 uIO8Lz/IltR72USXeOSGINiNsbC5DDEIZFnWHTjgy45va2MWziQrLhyQXI55ImjUcyFp
 3VcucIu7vPI/VLx2/2VXWyjprJt2TP4RcAeJCcNXmgVznc13CaCzv/W/4ruLw18qmV0M
 K39hI1KJ/xXZRgngFYdnOs+ufNkoZxjXib0GQRMmk2MYH4okAQbYQSPfPuLV8k+Ccx0X
 OdBP+CfxrX6vPOwnaueJ4Z7kfedll4ZDFRA23QyxZoPhC2PgVd+Y05RvPSrdO+Rmln54
 TY7w==
X-Gm-Message-State: AOJu0Yxi0+swviUcN8AkU+1S/ggBlMTNBPnaxG+Iw/dQyppXNPnWP8Va
 16eTv1PbrNoDq0nkX/WItbdymZYh+3NsDvu7e9nI23ZGBv5vHoU7OdG75J2fQrc6b1A=
X-Gm-Gg: ATEYQzzGpU2/wusGeQfTugjxRArSDE31lGGvmW1Hw0jAhAsJGkhs6M8+S82qHXa6Jan
 kFPQnqvc+AkoIeNVGedZS6rUxvpLRQKkqSiDAQvITpd+nPNVTLgoG0nOHlCbo7yuktzV4IusfAM
 hjtaFqemJuRcriYaD2yAIkLhFGE4uRkItpxUD91d9gnHQvlPXTDgZJIUdYvZYxG7A43N6LKlLeO
 o/+ALP7vS2rkhvhnxcXTB5O+xtJeU4K/6F32KCN4zcuVU6WxdCqwFje2x1W+4EYzfj2uFsag9/l
 PFngDdpDns4DeB0rftaESTYsTLw4ur7agYpTVdfTiSRxbrmTqlWAwkJS6Fw3HSL++CZscOBF6cn
 eQrMfi4PyG4VG6jaAFJdhHloPKBSB/A3hfChVRsFWwC/utWN/Xxmlddz5UMatfcoDSXq8s2Qcot
 oWcW3TAbb2M4+GufC83iSIgJKhIKSAujma2Ts=
X-Received: by 2002:a05:7022:69a5:b0:123:330b:398 with SMTP id
 a92af1059eb24-12a96eef4c0mr51796c88.19.1774368765325; 
 Tue, 24 Mar 2026 09:12:45 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a736bb1ccsm15239101c88.14.2026.03.24.09.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:12:45 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:11:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH 5/8] bus: factorize devargs lookup
Message-ID: <20260324091121.684bf6c3@phoenix.local>
In-Reply-To: <20260323105306.1531689-6-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-6-david.marchand@redhat.com>
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

On Mon, 23 Mar 2026 11:52:59 +0100
David Marchand <david.marchand@redhat.com> wrote:

> Each bus reimplements some similar devargs lookup code.
> 
> The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> device names. We can't use the .parse existing handler from outside the
> bus code itself, as the size of the bus specific device location address
> is unknown.
> Introduce a bus specific helper to compare two device names and
> hide this ugly detail.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> Changes since RFC v3:
> - fixed doxygen,
> 
> ---

More AI review:
Patch 5/8: bus: factorize devargs lookup

Warning: The Doxygen for rte_bus_find_devargs() in bus_driver.h
describes the bus parameter as "A pointer to a rte_bus structure
describing the bus to be unregistered" -- this is copy-pasted from
rte_bus_unregister. Should say something like "the bus to search for
devargs on."

Warning: The Doxygen for rte_bus_devname_compare_t has two issues: the
@return says "true or false" but the function follows strcmp semantics
(0 for match, non-zero for no match), and the @param descriptions both
say "device information location address" when they should say "device
name string."
