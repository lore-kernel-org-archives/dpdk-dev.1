Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B4C021B8
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 17:30:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B33DD41143;
	Sat, 22 Feb 2025 18:30:20 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 58536402B7
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:30:19 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22104c4de96so54224005ad.3
 for <dev@dpdk.org>; Sat, 22 Feb 2025 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740245418;
 x=1740850218; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyRMygBFW2/xkhDhb1JNiQ8UAxbqXrWzjoPtVaqRMfI=;
 b=FNWFSHQqHJdIaATbCYCiJABUdgB9mRckwZ/JLoBNDqR20aCccsXKZRJHmmYmSjO0/M
 VwZRAuPyNccpU01FNWGBa5mqVLZbRX5C8ZEDkcMUpFlMSFPhgcH3f03xEmMIPDZewa9u
 cITFlmKcPc24CHkHXyVbt5nghjXqqRMVC54drSy+4UDWuhrFqX2cw7kXEEMYznNBK0KA
 DoJUL9JBl9v/pCp4ML19K/dCJ4PgS7uvzO0vwLH0/0z+i6Ky8HtzUmcjfMLmZk3UWS4Z
 4QnRXsXR+CxHOZb3kqmCC6ieRs+OPk7c7eLWEUOlqsJL0LujOKMvLITzR+EU1uFL52a8
 UiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740245418; x=1740850218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyRMygBFW2/xkhDhb1JNiQ8UAxbqXrWzjoPtVaqRMfI=;
 b=pYYMB13jMfYguD7xKpKPVGjtS+qeLUqRFvldkT4Ogg8CzqASDQVXLXOxP9Z4soCDio
 vU5eSnGQPFw1JdmL/DPkQBf3QVRkOT8Twyvbl8M625Kn///AWyHQVWH07jX6nyXp4BRK
 sCbUAOmZ1oorvsAsJBwhCrYImQvjqvac0hGVoNQMbCvETAhdZUnoRjcqXUxfibJtvvLq
 LpU0j5p82P+YQ0S5e5An3fbj7fXjCRBf8VoimLwwvwEesmit8uM2xV2e1MheD9J5kqLG
 +uNp6qGXvj0eUXQoJs3z7enqOoGdHaNk9bs9fU3Fw+wC1w9jZY0JR2/Lc75PWcdXNrFX
 vdPA==
X-Gm-Message-State: AOJu0YxC9DmIxmEQ2LfYAKWjSKXDcHpBmijPuH8vii5Hm13Csv1Uokqm
 vTnOwTeJJeDeau9iSCxn63S7thnaU2CeFi3FV81R4C2a4lKG1iWE1sdGHPE5s2riCHvXDOwXUpf
 O
X-Gm-Gg: ASbGncu2xL/byy70Y+ceXnYBbc+1Y6CQIhQdBlZ2ipJCusqB05d1sjg6Tdsf0DMEOAC
 ZQl9wKiGesOiZpJyY3y8pdI9e9w3AQ0Ac9nr0AY4jyvF+mrLeGwiToenzIxsPrY8lmXdUveiz+T
 Rzazd4LmWhmZb0w7tO2dHZl3/5EOuT0b2YkrqWxUPnd/yqn+fpF11UAiIa6WwlLh39PHxaAx2l/
 uORLZpsJkT5RBlGLsAmCJo1UHYHRLu+Wc7NlxeY0lHqqy2d+JlPEGjQ8c+J2sEkXFth65no9kL0
 dADEsVnhLVD3uGJ5fTrVDL35CK1hlxkS/+IBouvloIGbVQz0Y8rSZ9qV1lTiRvFq5h30V2RgCZa
 mgLk=
X-Google-Smtp-Source: AGHT+IEzLxWxPTGlNnCbztlJCEbsRW4MsQqFUyxuUDfJl8lN0oXaYHDV0Lph2vF3ULoCPNFPz7/s3Q==
X-Received: by 2002:a05:6a21:78a9:b0:1ee:a914:1d5a with SMTP id
 adf61e73a8af0-1eef3c569ccmr15250008637.2.1740245418256; 
 Sat, 22 Feb 2025 09:30:18 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73260f9e6e2sm14417228b3a.79.2025.02.22.09.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 09:30:17 -0800 (PST)
Date: Sat, 22 Feb 2025 09:30:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <qianr@yunsilicon.com>,
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>,
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, <zhenghy@yunsilicon.com>
Subject: Re: [PATCH 00/12] net/xsc: Resolve issues from PVS and Coverity Scan
Message-ID: <20250222093016.4b4d615b@hermes.local>
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
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

On Sat, 22 Feb 2025 11:57:59 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> This patch series resolves several issues reported by PVS and Coverity Scan,
> which were earlier forwarded to us by Stephen Hemminger.
> 
> ---
> Renyong Wan (12):
>   net/xsc: avoid integer overflow
>   net/xsc: remove useless call
>   net/xsc: address incorrect format warnings
>   net/xsc: remove always-true if expressions
>   net/xsc: avoid variable is assigned but not used
>   net/xsc: check possible null pointer dereference
>   net/xsc: avoid potential null pointer before used
>   net/xsc: remove always-true part of if expression
>   net/xsc: avoid assign the same value to a variable
>   net/xsc: avoid initialize by same function
>   net/xsc: optimize memcmp returns not 0 check
>   net/xsc: avoid pointer cast to unrelated class
> 
>  drivers/net/xsc/xsc_dev.c       |  2 +-
>  drivers/net/xsc/xsc_ethdev.c    | 35 ++++++++----
>  drivers/net/xsc/xsc_np.c        | 17 +++---
>  drivers/net/xsc/xsc_rx.c        | 31 ++++++-----
>  drivers/net/xsc/xsc_tx.c        |  7 +--
>  drivers/net/xsc/xsc_vfio.c      | 97 ++++++++++++++++++++-------------
>  drivers/net/xsc/xsc_vfio_mbox.c |  2 +-
>  7 files changed, 111 insertions(+), 80 deletions(-)
> 

Applied to next-net Great to see the Coverity issues fixed.
Ran PVS Studio on it, and there are three potential things that could be fixed later.

1. xsc_ethdev.c (838)
V1027	Pointer to an object of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

This is a generic issue in bus_pci_driver.h that can be suppressed there.

2. xsc_rx.c (351)
V522	There might be dereferencing of a potential null pointer 'rxq_data'.

Looking at the code, there are two loops over the rxq's the first one just
dereferences, and the second pass uses a helper function that could return NULL.
Why not just use do direct index in second one:

-- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -347,7 +347,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
        rqn_base = rte_be_to_cpu_32(out->qpn_base) & 0xffffff;

        for (i = 0; i < priv->num_rq; i++) {
-               rxq_data = xsc_rxq_get(priv, i);
+               rxq_data = (*priv->rxqs)[i];
                rxq_data->wqes = rxq_data->rq_pas->addr;
                if (!xsc_dev_is_vf(xdev))
                        rxq_data->rq_db = (uint32_t *)((uint8_t *)xdev->bar_addr +


3. xsc_vfio_mbox.c (575)
V1048	The 'size' variable was assigned the same value.

This one is harmless, since both commands have same size, the tool
is just being annoying. Can suppress via comment

--- a/drivers/net/xsc/xsc_vfio_mbox.c
+++ b/drivers/net/xsc/xsc_vfio_mbox.c
@@ -572,7 +572,7 @@ xsc_vfio_mbox_init(struct xsc_dev *xdev)
        cmdq->req_lay = cmdq->req_mz->addr;

        snprintf(name, RTE_MEMZONE_NAMESIZE, "%s_cmd_cq", xdev->pci_dev->device.name);
-       size = (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_rsp_layout);
+       size = (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_rsp_layout); // -V1048
        cmdq->rsp_mz = rte_memzone_reserve_aligned(name,
                                                   size, SOCKET_ID_ANY,
                                                   RTE_MEMZONE_IOVA_CONTIG,
