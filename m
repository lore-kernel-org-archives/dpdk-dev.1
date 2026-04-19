Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C05AEA71A2
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 15:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BC2D402B5;
	Sun, 19 Apr 2026 17:41:11 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 3DA1640291
 for <dev@dpdk.org>; Sun, 19 Apr 2026 17:41:10 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c63e942f3so3011521c88.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776613269;
 x=1777218069; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lLBba6vC6wxplQRFsNk4g1YK8oJKIAuTUNJXr1heY8=;
 b=Bnm/0scp9q9zmNmCrXOid0JAU8Jwrumhl/Nu2vv1iVa0n8RkjTNElyJuBWdWDQ+Cce
 Sp71QoTFo/a0zS/QFhSLK21CQUQlXpR5xLD5rVbtzCu2M+INW4tBTKFV3RLE+xq+qP8D
 GtE03Qe0ykLzN/rQDtZp07oAYuv/ShLXI+L0Wz9uPwxYdq+ueTbjHI79TH8FjxkYTdWG
 Vm73uRVljJRkHI56c438EmUIvIEx9b++hlW/4k8XNXylTGt9VSP2I+11swW1/U7lLV1U
 O8ps/tPMwkCYVMXmS7s7zZKX8FB8B2acvpfHqrzZ3TjDCgC3KM/eybAw3+gAfqjJWIMx
 cCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776613269; x=1777218069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8lLBba6vC6wxplQRFsNk4g1YK8oJKIAuTUNJXr1heY8=;
 b=PSQkR+Vn9V+8ZnO4IDFr48L1o8GjKElD8bfktBfI9j33mafcaY7El5ZwtPAO57mT4R
 Q1JOMvYfjsUEqcHa7P0ZWBlt8OeoUJKm7+5CawfjiMcB8XHBvBwa9X/28g7oS2bTcpvX
 JlnfGZV/gUcXk2ImHnjdnxzNXQTF0Y/HQ2/UC7kSLnFN3pgD8npwcP3yb0VBOfqhFGgI
 aKjv70N0X8Q6U9Bs8Qc5P7SlJn5vxfvluNnnfxtP7nrtBXRymOmYUkSe/BX29y/Ppnbm
 AoPPgy8UhHWiYHyf5eIfOHYgJ1fzQTd+wMC1WNXBmG5BKZPixq+nZVmYsqQvvzy/Ehxr
 T1eA==
X-Gm-Message-State: AOJu0YxdVfjs4GwIaHWjw3fYbbvWjmyblaTkF8UprByzW3EkZKOCj1Wa
 YgQd/07krFPpUlx1n9tZDTOKDruadByCQHl51PUgUSedOpGUO+9BoPG4BRAL0eGjxUU=
X-Gm-Gg: AeBDietWKWGNU+GHjfDNyjDIaxkjOKaO45UlZdykjpIE23WGh4t1s1b0Ln8BP/OjsxX
 oPsyilOsAHrthB2EICcm0cC+oqATHq2BqlEm9L0LmGxia+g3lzWUEFqJ0gj+J+JB1IDWm8SkPh4
 60QbT812vIY3ckVFu0qxzVkY9Z0NsFXOD7r/fCA4NtJTwp4RXFIDSe3ewL2KVlR2jXOvrOQBGir
 TdhcclHoiisSSK9zC+PBUSeYiijc0XXhoA/+TuyB711QWBEdRMK2i08kIOOlP6z7ossSit7IF25
 j71+rvWiYiJ3msXtLFbUoY6EnZ0PbHkypKE6Mv3nw0t0Qn/LN/dhiM54yhSkqr8kK8KCDOJRgF9
 Uc+4sE2ztT6+Yl/iO8T+cdsWlznwHkT2NYTZKbIoX3Ucl3RrtjgBD7awMNkAuCIPd+G00WlTzTP
 LYNRiJxTvjo+P6BLPkTD54PelY4SV3fT0a5N5YP/75Z0H8SA==
X-Received: by 2002:a05:7301:1698:b0:2da:55db:5764 with SMTP id
 5a478bee46e88-2e47972417bmr5618137eec.17.1776613268880; 
 Sun, 19 Apr 2026 08:41:08 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e7025cf413sm4572056eec.15.2026.04.19.08.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 08:41:08 -0700 (PDT)
Date: Sun, 19 Apr 2026 08:41:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 04/29] net/ixgbe: use adapter in flow-related calls
Message-ID: <20260419084105.16a6e751@phoenix.local>
In-Reply-To: <ee372b81daa4cea52c499241bbdc1fb09affb3a3.1775826526.git.anatoly.burakov@intel.com>
References: <cover.1775826526.git.anatoly.burakov@intel.com>
 <ee372b81daa4cea52c499241bbdc1fb09affb3a3.1775826526.git.anatoly.burakov@intel.com>
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

On Fri, 10 Apr 2026 14:12:58 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Currently, a lot of rte_flow-related code paths depend on using the `dev`
> pointer. This has been okay up until now, because all the infrastructure
> surrounding rte_flow has been ad-hoc and did not have any persistent driver
> identification mechanism that works across multiple drivers, so any API
> call was tied to immediate rte_eth_dev API invocation.
> 
> However, with coming shared infrastructure, we can no longer rely on things
> that are process-local (such as `dev` pointer), and because most calls can
> be implemented using `adapter` anyway, we'll just switch the flow-related
> internal calls to use `adapter` instead of `dev`.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Rather than one monster AI review, lets split the responses.

----------------------------------------------------------------------
Patch 4/29: net/ixgbe: use adapter in flow-related calls
----------------------------------------------------------------------

Error: In ixgbe_clear_all_l2_tn_filter(), the macro is called with
the wrong argument:

  struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev);

This casts the rte_eth_dev pointer directly to ixgbe_adapter, which
is a type confusion. Every other call site in this patch passes
dev->data->dev_private. Should be:

  struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
