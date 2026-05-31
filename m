Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED15FCD6E57
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 May 2026 22:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EC4D4060A;
	Mon,  1 Jun 2026 00:34:17 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 6A94C40612
 for <dev@dpdk.org>; Mon,  1 Jun 2026 00:34:15 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-137335bc3caso7447045c88.0
 for <dev@dpdk.org>; Sun, 31 May 2026 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780266854;
 x=1780871654; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDH3awGX2+jIfar3/vNQcwka38rpsaE7+yGJNu97uro=;
 b=JlkMyEQjSFmy1wYidHc09BJ8zbEmMLgm91P2wq3VKNC4MVuaT2l0F7GiDCLl9TC3nB
 r4dPli693rOVyBXX/tdoWqtHoX3A82mdCDGC3pXtARlW9IZAsN5Q7MXPzBp6S7FNOZYJ
 i8Ea2ZDQTYtpONvURPoEWa5N8hjZWsDr68pr9cgLMjWV8VrwTR7DBqeIdQMXCdpcp66W
 gq9Cl00NcrkgGp7jQJCE6hmenU1nFyR94ZGRZqk1XqQzowsyLVGKNNt3euRS6DXdls8H
 g9CtxvI65AFyhnXKyfsdVznFmzrTUINEfAmJjlh7lphxKAibsCDEg45iPw+xBP7OPNGb
 GSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780266854; x=1780871654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDH3awGX2+jIfar3/vNQcwka38rpsaE7+yGJNu97uro=;
 b=XlECHqKZw+UhQiMtzcaN7Ih2O/hnBRUtDy1rxq0+GfDdl6OR0p6nYuiirk5ZKgFUpe
 wafDQ0mAISIYHuqzpFYfxp/CHqxUns97PB57Rzv7vK+xVO60Zp/othcNLnMNtcoqU8w8
 dR9ULxECSheXCP9XsChdWFli9cRq3zRF0X5cBTUWVfKswE3ObarqfIN2HUunRcJhEMmh
 AoMZ+3QurkkJJfoCTratsHVStuG6mCd9ghS79Sv+lhYaTl3xVGiVhX14bkQYy4SbsTBJ
 VMbaA3k45II7OGZZkUFYTe4BkuyrzQKwEIfx5u4xyItDHuwPBRR5G5qG1iEagzwZY0N3
 nE1A==
X-Gm-Message-State: AOJu0YxlLXsccgS2FeLsP2A6l86iUa7Rh2FyTKwwm+7rMgAb+XmlFYgs
 E8KgDusUg1Y6Zes7LqAC8xXiwgZPxMRNz9y5TfAuAsuJsOCJ1fCznjWDaoZ2nExTg8Y=
X-Gm-Gg: Acq92OFS3kEguf3f5uo0uzRlo8I5x2SwNtF+XhkJCoS6STcHoQiTA6EkNgETTzO9Vvh
 pwCMikTMjfdDO6VKiLMuZH2l2+oSU+OiNWBe2rMuZ5eEZIc0KeOjWLTqvg9ShJYvGEqg0PhgLKO
 k3DDTAjut6VtaM5s+YFxkzM7Qg4KSKsIPtRPvFMWEOoP/028WHyS0fd9tKb8qvCZRHB1sHQ1D5A
 TM3iLs7vdSnYx1LWqpTY0juq2qelWUkFpEQkclsTObDGq13R04+xjj4f/84PgzUI+V7HX0Za2OG
 NjHAW+zrvF/4Nc0L+IzPO02j6C9fsGOBwW3ROFVjaHSrE2OZzBfIb1DjKjIWRcBIFXVbgxffMJI
 h4qgKhTTX4EByshyW8TnDsjNIAqZny6iB5lj3en3wSFAOUYJdPKpJjU9Fa+cO989FWJd4JmtvDC
 Se81u4uDDGQLgOI+xlCElHCTikVFqEMVfNWdbbhOeH/L2Rdgmeh5+0IBPw030JXkcSf9BBye+Oj
 fU=
X-Received: by 2002:a05:7300:5714:b0:2ed:e14:7f54 with SMTP id
 5a478bee46e88-304fa693605mr3669614eec.30.1780266854417; 
 Sun, 31 May 2026 15:34:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c10c1sm7033495eec.1.2026.05.31.15.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 15:34:14 -0700 (PDT)
Date: Sun, 31 May 2026 15:29:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 02/20] net/sxe2: add AVX2 vector data path for Rx and Tx
Message-ID: <20260531152947.24462c47@phoenix.local>
In-Reply-To: <20260530184625.480938-3-liujie5@linkdatatechnology.com>
References: <20260530184625.480938-1-liujie5@linkdatatechnology.com>
 <20260530184625.480938-3-liujie5@linkdatatechnology.com>
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

On Sun, 31 May 2026 02:46:07 +0800
liujie5@linkdatatechnology.com wrote:

> +static __rte_always_inline void
> +sxe2_tx_desc_fill_one_avx2(volatile union sxe2_tx_data_desc *desc, struct rte_mbuf *pkt,
> +			   uint64_t desc_cmd, bool with_offloads)
> +{

Why do you need to always inline here?
After investigating lots of performance cases, my conclusion has been that
no new code should use always_inline unless it has special __rte_constant()
optimizations and/or can show significant benefit on a benchmark.

Just inline should do fine, the compiler cost optimizer will figure
out if inline makes sense.
