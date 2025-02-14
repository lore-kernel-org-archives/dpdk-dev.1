Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528D2C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 23:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42C294028A;
	Sat, 15 Feb 2025 00:27:13 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id CEC1D40281
 for <dev@dpdk.org>; Sat, 15 Feb 2025 00:27:11 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so37719885ad.3
 for <dev@dpdk.org>; Fri, 14 Feb 2025 15:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739575631;
 x=1740180431; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcpZ7YTBGOvhNRW4bzAe0u7oqe8FESdzJpmX+73VrO4=;
 b=Bp2zYYR88dqYGHKH/YcfGI1AYgglwffsUVmgLFqF03JWuEHK3hr682mPzgqqHF3cat
 VgxMYd2a2yV9AebBsNFDc1fnRUQ3LRBN2f4Ksij70tnja81SIVmB9d83q48OGPTqpei8
 AVxNCaDp4X8lJ+3i7//DCS7i8XN3QGtUhiNdFD4Ks75pZyoIghyV7r6fWaW4yK60KpoA
 QCAOKSCLVnW1levTD4tCPsLEg/BRTnGqnAZ8pA5Uwo8xMhaqtEWpxBiWC3JuitOL5gxP
 GYpvAZwDnFBLmNvgWKirV3nW6NMEtunSSOYdS0F2XQjPrFSNFdFHqBqJ+4/ZLAigBBca
 OpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739575631; x=1740180431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcpZ7YTBGOvhNRW4bzAe0u7oqe8FESdzJpmX+73VrO4=;
 b=ZQhzIjTUZMbrnoFsoGAR6zepPWcC6H+KYPY8HUDOf1Zr00JHVdkrRmC5AJuk13cM7w
 oXEv8qtqkWOgSa50tdsAYB9q/dhnijvhE+FtLBDx4K2Gzf6cuENJqeZyKzMshIfKUmaT
 HJb+ChEd7b72Nq+HKkx9kG8Nr9MJ91ZkJtNK8n1JLGrbESiYxuIOs/M6fux+GcdUw9Ve
 fSIiflW0xbn8gnDhutAQ6r19ukOxZdc5hS2BOafHLHQW1Q4zEEW0uUCYv0hdwvLV129r
 AoydqgP+GYZAo3PenqhnJbITgjfesSxrkQEI60Wd4X5qzrEsCtu74IA5V4Ow+eb7QS8U
 Cd6g==
X-Gm-Message-State: AOJu0YxUqbH0pk8HpWgfMp9ccanBSQs6AADVeVrxlXFZwNVuU4Vxn8G9
 vGkfQznVsyH6nAYLP8TTrDKLF8S+1hpa7dUIw5hxNWRK2+/v5mzYan/JsGMNMSQ=
X-Gm-Gg: ASbGnctSycclsWU3daSAKS0mFzv7SGVX7Rw/7eMfVFWAg5/uyije82wxn2TfKGMhr1X
 sFI0DsjkPhxrl3Ar2wIxDUEu8s9c2T6Yrrndi3qg1u9JD+Zx7vfcgKK4n7t15luRHGanzTKm0Wc
 crInYnVGNZggu8if7tzvOLBHQTP8dn4mo3YZP9RW+2wKrmRnCjNTMRStR6ol2T6CN0uD9HISZcm
 6V1hP/MOuEUqI7fl33TTjakU1YTqDEDCX6midLjK5sOjGokoFN0EM2mr57z73UFExR5zBM3JNm7
 5e53vCz6NNQ+cWkbXmXiSy/aiPbzKwOUWVqeGDJj4IEyJ9UjDUqQj416TVXtNaAjqnKw
X-Google-Smtp-Source: AGHT+IH8ln1rY+HYGRI3mk6bxzD4C8hw9Zxj3bibg5pnwzuOuflUPmUE6dGSbA5Yqwpc3/8vqR56lA==
X-Received: by 2002:a05:6a00:4fd6:b0:731:e974:f9c2 with SMTP id
 d2e1a72fcca58-7326144ab2fmr2476261b3a.0.1739575630835; 
 Fri, 14 Feb 2025 15:27:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73265a589ebsm13904b3a.143.2025.02.14.15.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 15:27:10 -0800 (PST)
Date: Fri, 14 Feb 2025 15:27:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <ferruh.yigit@amd.com>, <thomas@monjalon.net>,
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>,
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH v7 00/15] XSC PMD for Yunsilicon NICs
Message-ID: <20250214152708.4916cf2b@hermes.local>
In-Reply-To: <20250128144649.1956159-1-wanry@yunsilicon.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
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

On Tue, 28 Jan 2025 22:47:22 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> This xsc PMD (**librte_net_xsc**) provides poll mode driver for 
> Yunsilicon metaScale serials NICs.
> 
> Features:
> ---------
> - MTU update
> - TSO
> - RSS hash
> - RSS key update
> - RSS reta update
> - L3 checksum offload
> - L4 checksum offload
> - Inner L3 checksum
> - Inner L4 checksum
> - Basic stats
> - Stats per queue
> 
> Support NICs:
> -------------
> - metaScale-200S   Single QSFP56 Port 200GE SmartNIC
> - metaScale-200    Quad QSFP28 Ports 100GE SmartNIC
> - metaScale-50     Dual QSFP28 Port 25GE SmartNIC
> - metaScale-100Q   Quad QSFP28 Port 25GE SmartNIC
> 
> ---
> 
> v7:
> * Remove the packed attributes of sub structures and unions.
> * Remove the cast of xdev->dev_priv.
> * Remove the cast of malloc return value.
> * Define the size of xdev->name to PCI_PRI_STR_SIZE.
> * Change the name of Wanrenyong to Renyong Wan
> 
> v6:
> * Remove unnecessary paren.
> * Add the feature of stats per queue in xsc.ini.
> * Use memcpy instead of rte_memcpy in non critical path.
> * Rebase from the main branch and merge release notes.
> * Replace __rte_packed with __rte_packed_begin and __rte_packed_end.
> 
> v5:
> * fix compilation errors.
> * fix coding style issue with misspelling.
> * remove some unnecessary parameter checks.
> * remove unnecessary call of rte_wmb.
> * Rearrange elements in structure to avoid holes.
> 
> v4:
> * Based on the review comments from previous versions, reconstruct the xsc PMD to eliminate
>   the dependency on rdma core library and proprietary kernel driver, while adding support for
>   the vfio kernel driver.
> 
> v3:
> * fix compilation errors
> 
> v2:
> * fix checkpatch warnings and errors
> 
> ---
> Renyong Wan (15):
>   net/xsc: add xsc PMD framework
>   net/xsc: add xsc device initialization
>   net/xsc: add xsc mailbox
>   net/xsc: add xsc dev ops to support VFIO driver
>   net/xsc: add PCT interfaces
>   net/xsc: initialize xsc representors
>   net/xsc: add ethdev configure and RSS ops
>   net/xsc: add Rx and Tx queue setup
>   net/xsc: add ethdev start
>   net/xsc: add ethdev stop and close
>   net/xsc: add ethdev Rx burst
>   net/xsc: add ethdev Tx burst
>   net/xsc: add basic stats ops
>   net/xsc: add ethdev infos get
>   net/xsc: add ethdev link and MTU ops
> 
>  .mailmap                               |   5 +
>  MAINTAINERS                            |  10 +
>  doc/guides/nics/features/xsc.ini       |  19 +
>  doc/guides/nics/index.rst              |   1 +
>  doc/guides/nics/xsc.rst                |  31 +
>  doc/guides/rel_notes/release_25_03.rst |   4 +
>  drivers/net/meson.build                |   1 +
>  drivers/net/xsc/meson.build            |  17 +
>  drivers/net/xsc/xsc_cmd.h              | 387 +++++++++++
>  drivers/net/xsc/xsc_defs.h             | 100 +++
>  drivers/net/xsc/xsc_dev.c              | 397 +++++++++++
>  drivers/net/xsc/xsc_dev.h              | 184 +++++
>  drivers/net/xsc/xsc_ethdev.c           | 917 +++++++++++++++++++++++++
>  drivers/net/xsc/xsc_ethdev.h           |  63 ++
>  drivers/net/xsc/xsc_log.h              |  24 +
>  drivers/net/xsc/xsc_np.c               | 492 +++++++++++++
>  drivers/net/xsc/xsc_np.h               | 154 +++++
>  drivers/net/xsc/xsc_rx.c               | 512 ++++++++++++++
>  drivers/net/xsc/xsc_rx.h               |  65 ++
>  drivers/net/xsc/xsc_rxtx.h             | 191 +++++
>  drivers/net/xsc/xsc_tx.c               | 354 ++++++++++
>  drivers/net/xsc/xsc_tx.h               |  62 ++
>  drivers/net/xsc/xsc_vfio.c             | 746 ++++++++++++++++++++
>  drivers/net/xsc/xsc_vfio_mbox.c        | 691 +++++++++++++++++++
>  drivers/net/xsc/xsc_vfio_mbox.h        | 142 ++++
>  25 files changed, 5569 insertions(+)
>  create mode 100644 doc/guides/nics/features/xsc.ini
>  create mode 100644 doc/guides/nics/xsc.rst
>  create mode 100644 drivers/net/xsc/meson.build
>  create mode 100644 drivers/net/xsc/xsc_cmd.h
>  create mode 100644 drivers/net/xsc/xsc_defs.h
>  create mode 100644 drivers/net/xsc/xsc_dev.c
>  create mode 100644 drivers/net/xsc/xsc_dev.h
>  create mode 100644 drivers/net/xsc/xsc_ethdev.c
>  create mode 100644 drivers/net/xsc/xsc_ethdev.h
>  create mode 100644 drivers/net/xsc/xsc_log.h
>  create mode 100644 drivers/net/xsc/xsc_np.c
>  create mode 100644 drivers/net/xsc/xsc_np.h
>  create mode 100644 drivers/net/xsc/xsc_rx.c
>  create mode 100644 drivers/net/xsc/xsc_rx.h
>  create mode 100644 drivers/net/xsc/xsc_rxtx.h
>  create mode 100644 drivers/net/xsc/xsc_tx.c
>  create mode 100644 drivers/net/xsc/xsc_tx.h
>  create mode 100644 drivers/net/xsc/xsc_vfio.c
>  create mode 100644 drivers/net/xsc/xsc_vfio_mbox.c
>  create mode 100644 drivers/net/xsc/xsc_vfio_mbox.h
> 

Now that XSC is merged to main, there are a number of possible problems reported
by PVS studio.

The Vxxx value is the PVS studio error code.

xsc_dev.c (292)
V576	Incorrect format. Consider checking the fifth actual argument of the 'rte_log' function. The UNSIGNED integer type argument is expected.
xsc_dev.c (292)
V576	Incorrect format. Consider checking the sixth actual argument of the 'rte_log' function. The UNSIGNED integer type argument is expected.
xsc_ethdev.c (724)
V547	Expression 'config->tso' is always true.
xsc_ethdev.c (728)
V547	Expression is always false.
xsc_ethdev.c (729)
V547	Expression 'priv->is_representor' is always true.
xsc_ethdev.c (316)
V1001	The 'ret' variable is assigned but is not used by the end of the function.
xsc_ethdev.c (141)
V522	There might be dereferencing of a potential null pointer 'rxq'.
xsc_ethdev.c (165)
V522	There might be dereferencing of a potential null pointer 'txq'.
xsc_ethdev.c (650)
V526	The 'memcmp' function returns 0 if corresponding buffers are equal. Consider examining the condition for mistakes.
xsc_ethdev.c (825)
V1027	Pointer to an object of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.
xsc_np.c (175)
V595	The 'in' pointer was utilized before it was verified against nullptr. Check lines: 175, 176.
xsc_np.c (140)
V560	A part of conditional expression is always false: (rss_conf->rss_hf & (0UL << 50)).
xsc_np.c (175)
V575	The potential null pointer is passed into 'memset' function. Inspect the first argument. Check lines: 175, 174.
xsc_np.c (142)
V1048	The 'outer' variable was assigned the same value.
xsc_np.c (192)
V1027	Pointer to an object of the 'xsc_np_mbox_in' class is cast to unrelated 'xsc_np_mbox_out' class.
xsc_rx.c (296)
V595	The 'in' pointer was utilized before it was verified against nullptr. Check lines: 296, 297.
xsc_rx.c (45)
V560	A part of conditional expression is always false: ret == - 1.
xsc_rx.c (45)
V560	A part of conditional expression is always false: ret == 0x2.
xsc_rx.c (296)
V575	The potential null pointer is passed into 'memset' function. Inspect the first argument. Check lines: 296, 295.
xsc_rx.c (284)
V522	There might be dereferencing of a potential null pointer 'rxq_data'.
xsc_rx.c (391)
V522	There might be dereferencing of a potential null pointer 'rxq_data'.
xsc_rx.c (430)
V522	Dereferencing of the null pointer might take place. The potential null pointer is passed into 'xsc_rxq_elts_alloc' function. Inspect the first argument. Check lines: 'xsc_rx.c:430', 'xsc_ethdev.c:274'.
xsc_rx.c (361)
V576	Incorrect format. Consider checking the fifth actual argument of the 'rte_log' function. The UNSIGNED integer type argument is expected.
xsc_rx.c (361)
V576	Incorrect format. Consider checking the ninth actual argument of the 'rte_log' function. The SIGNED integer type argument is expected.
xsc_rx.c (410)
V576	Incorrect format. Consider checking the ninth actual argument of the 'rte_log' function. The SIGNED integer type argument is expected.
xsc_rx.c (447)
V656	Variables '(mbuf)->data_len', '(mbuf)->pkt_len' are initialized through the call to the same function. It's probably an error or un-optimized code. Check lines: 445, 447.
xsc_rx.c (335)
V1027	Pointer to an object of the 'xsc_cmd_create_multiqp_mbox_in' class is cast to unrelated 'xsc_cmd_create_multiqp_mbox_out' class.
xsc_tx.c (18)
V522	Dereferencing of the null pointer might take place. The potential null pointer is passed into 'xsc_txq_elts_alloc' function. Inspect the first argument. Check lines: 'xsc_tx.c:18', 'xsc_ethdev.c:232'.
xsc_tx.c (55)
V576	Incorrect format. Consider checking the eighth actual argument of the 'rte_log' function. The SIGNED integer type argument is expected.
xsc_tx.c (86)
V576	Incorrect format. Consider checking the eighth actual argument of the 'rte_log' function. The SIGNED integer type argument is expected.
xsc_tx.c (218)
V1048	The 'cs->has_pph' variable was assigned the same value.
xsc_vfio.c (434)
V595	The 'in' pointer was utilized before it was verified against nullptr. Check lines: 434, 435.
xsc_vfio.c (434)
V575	The potential null pointer is passed into 'memset' function. Inspect the first argument. Check lines: 434, 433.
xsc_vfio.c (340)
V576	Incorrect format. Consider checking the fifth actual argument of the 'rte_log' function. The SIGNED integer type argument is expected.
xsc_vfio.c (486)
V576	Incorrect format. Consider checking the seventh actual argument of the 'rte_log' function. The SIGNED integer type argument is expected.
xsc_vfio.c (88)
V1027	Pointer to an object of the 'xsc_cmd_query_hca_cap_mbox_in' class is cast to unrelated 'xsc_cmd_query_hca_cap_mbox_out' class.
xsc_vfio.c (207)
V1027	Pointer to an object of the 'xsc_cmd_destroy_qp_mbox_in' class is cast to unrelated 'xsc_cmd_destroy_qp_mbox_out' class.
xsc_vfio.c (248)
V1027	Pointer to an object of the 'xsc_cmd_destroy_cq_mbox_in' class is cast to unrelated 'xsc_cmd_destroy_cq_mbox_out' class.
xsc_vfio.c (330)
V1027	Pointer to an object of the 'xsc_cmd_modify_qp_mbox_in' class is cast to unrelated 'xsc_cmd_modify_qp_mbox_out' class.
xsc_vfio.c (380)
V1027	Pointer to an object of the 'xsc_cmd_modify_raw_qp_mbox_in' class is cast to unrelated 'xsc_cmd_modify_raw_qp_mbox_out' class.
xsc_vfio.c (463)
V1027	Pointer to an object of the 'xsc_cmd_create_cq_mbox_in' class is cast to unrelated 'xsc_cmd_create_cq_mbox_out' class.
xsc_vfio.c (560)
V1027	Pointer to an object of the 'xsc_cmd_create_cq_mbox_in' class is cast to unrelated 'xsc_cmd_create_cq_mbox_out' class.
xsc_vfio.c (666)
V1027	Pointer to an object of the 'xsc_cmd_create_qp_mbox_in' class is cast to unrelated 'xsc_cmd_create_qp_mbox_out' class.
xsc_vfio_mbox.c (517)
V576	Incorrect format. Consider checking the seventh actual argument of the 'rte_log' function. The UNSIGNED integer type argument is expected.
xsc_vfio_mbox.c (575)
V1048	The 'size' variable was assigned the same value.
