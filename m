Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFB1F532CB
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 03:27:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37A3E402D6;
	Tue, 24 Mar 2026 04:27:42 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5D6AC4027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 04:27:40 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso359896a12.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774322859;
 x=1774927659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKpYBo7UIDyWXAI5gQVXuctUI80gDAer4mMJMYx7SfU=;
 b=S8+UhrrM3liCiI18MgkIjftackvstAh5Stt5YpBgnCaYIZBL5CkixxmAm4EkbLK3lr
 +DenTKFcJ3is380fpOscGZE9DBkybdu8VTDjZpazf8esmieYI/FJiMyc1c8Zu0OHB1vl
 HP6AVItcuQSitwyCyX9Gz63kmPInz3zHbSMZ+hdRVooJxs3JkWzHpbGEDdfKrFhZZjz7
 qD1EP9imty5vfq6IbVgqtRKutISS9H0Bi5fT72ySVTOBWu6n0ChduH9iz4w1guXj+WwV
 +AaqtfXjFNQcNpcK3AsYL54F5Y1ywEL0wad2iTOLptajX9TvBJ/emBmCBg4AmLLRVPqT
 BMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774322859; x=1774927659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lKpYBo7UIDyWXAI5gQVXuctUI80gDAer4mMJMYx7SfU=;
 b=o5eZS0v2QWxwoKhjeQG9jZBVxEjFQZfjkZQ15z3yzJzCf7wB5xjO7JXydDEHuyat63
 aeV3rCuTbsHhxVcF0zJo6QCfuQ9HjkzWSdYBszvnr4wfb5gTjY4wQZ6Ro7d6ecX+5KCr
 NSizA2Gy66Xh4Nt+/E14VAoNrtWu7DqVvUCMIH3Z+NfhiZ7MtSehbubeHvnps+AfoCt2
 TocADumFzcGxjPxu+N/agaFyV5+St+AbntSNbMt9/20xTVYORmdGl4Ocq6hSuSqjJymE
 PcTTZH03qJg5x3eYfnsr4EXzux0fbURg0S7W/vK/PNyU1c/tqBEPsYKO3XQze1lyOelU
 lSIw==
X-Gm-Message-State: AOJu0YwXzbqHTmvZJdQYV9NWwfHf0gJWvs90UIZa2mhXYtkhyHkyDhqU
 VcYntCXlQDm+pClV7ogxqUUeWe1UMgO/HaYEWSgiyum8vEt3sGZ34QIvQw4a4AV2eiw=
X-Gm-Gg: ATEYQzyLpPTp379TiLWZMH1yP+gArBHJfPg3ynTltdQyVHuSwtCWwqV3Y+ZGn0DiFuv
 R5CurskWKGJ14YnfHNO+8ySNdG/co1f93JgJ9YRPBLhtPTp7uWTSbe9b0CVoEhdvW9mSOSrXWrj
 CpxGwR0B4vwco0cy3+2O5aSLFShyr0Xb0joxSzyitvaC06ENJyHpgAF4dgmIuS4NgKfesyNlNKQ
 /Rxf8i1v4LkuxK02PDcOWVv6TFdATwW/HYOBH9VaOaAWPg3E/LemGeExgPttk+4gt2axpKJisZ8
 qi36Ex9F8S4MmIh6bzqeFI1BX4XZMlhWG5u5nms3TZBxxaolA44z3wN/2Ph1LD/pSBTU4qKBqTG
 texXPxBNzFDMM5OM7o+8pPoYVYIfjGSn/2uN0VnUBXllJz+H943ebZ3cjiKXRcguHmwmxPFexv2
 ZYUuse29McNcx2IlknZ65jMVSNW/yITSEMEQk=
X-Received: by 2002:a17:903:8c8:b0:2ae:46b9:c653 with SMTP id
 d9443c01a7336-2b08278b310mr124860355ad.33.1774322859194; 
 Mon, 23 Mar 2026 20:27:39 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08369617dsm161377655ad.71.2026.03.23.20.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 20:27:38 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:27:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [PATCH v8 0/7] hinic3 change for support new SPx NIC
Message-ID: <20260323202731.6db2afb1@phoenix.local>
In-Reply-To: <20260324015516.201-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260324015516.201-1-wff_light@vip.163.com>
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

On Tue, 24 Mar 2026 09:55:03 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Feifei Wang <wangfeifei40@huawei.com>
> 
> Change hinic3 driver to support Huawei new SPx series NIC.
> 
> v2:
> --fix build issues
> 
> v3:
> --fix community review comments and err reports
> 
> v4:
> --fix rss type assignment error
> 
> v5:
> --fix community ubuntu-22.04-clang err
> 
> v6:
> --fix atomic compilation error
> 
> v6:
> --fix community review comments
> 
> v7:
> --fix htn/stn ops function name error
> --update doc/guides for hinic3 driver
> 
> v8:
> --fix guides grammar issue
> --fix rss_type.ipv6_ext = 0 error
> 
> Feifei Wang (7):
>   net/hinic3: add support for new SPx series NIC
>   net/hinic3: add enhance cmdq support for new SPx series NIC
>   net/hinic3: use different callback func to split new/old cmdq
>     operations
>   net/hinic3: add fun init ops to support Compact CQE
>   net/hinic3: add rx ops to support Compact CQE
>   net/hinic3: add tx ops to support Compact CQE
>   net/hinic3: use different callback func to support htn fdir
> 
>  doc/guides/nics/features/hinic3.ini           |  11 +-
>  doc/guides/nics/hinic3.rst                    |   5 +-
>  doc/guides/rel_notes/release_26_03.rst        |   8 +
>  drivers/net/hinic3/base/hinic3_cmd.h          |  80 ++-
>  drivers/net/hinic3/base/hinic3_cmdq.c         | 370 ++++------
>  drivers/net/hinic3/base/hinic3_cmdq.h         | 112 ++-
>  drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 111 +++
>  drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 125 ++++
>  drivers/net/hinic3/base/hinic3_csr.h          |  18 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-
>  drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +
>  drivers/net/hinic3/base/hinic3_hwif.c         |  10 +-
>  drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-
>  drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c      | 182 ++---
>  drivers/net/hinic3/base/hinic3_nic_cfg.h      |  98 ++-
>  drivers/net/hinic3/base/meson.build           |   1 +
>  drivers/net/hinic3/hinic3_ethdev.c            | 275 ++++++--
>  drivers/net/hinic3/hinic3_ethdev.h            | 120 ++--
>  drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----
>  drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--
>  drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++--------
>  drivers/net/hinic3/hinic3_nic_io.h            | 163 ++++-
>  drivers/net/hinic3/hinic3_rx.c                | 267 +++++--
>  drivers/net/hinic3/hinic3_rx.h                | 182 ++++-
>  drivers/net/hinic3/hinic3_tx.c                | 456 ++++++------
>  drivers/net/hinic3/hinic3_tx.h                | 154 +++-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 167 +++++
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  63 ++
>  drivers/net/hinic3/htn_adapt/meson.build      |   7 +
>  drivers/net/hinic3/meson.build                |   8 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 151 ++++
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  46 ++
>  drivers/net/hinic3/stn_adapt/meson.build      |   7 +
>  36 files changed, 3379 insertions(+), 1445 deletions(-)
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.h
>  create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
>  create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
>  create mode 100644 drivers/net/hinic3/htn_adapt/meson.build
>  create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
>  create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
>  create mode 100644 drivers/net/hinic3/stn_adapt/meson.build
> 

The driver is clean but as a followup could you consider changing the
code to only use rte_zmalloc() where needed. The regular glibc has
more protections and is faster at alloc/free. The only reason to use
rte_malloc is when hugepages are needed for sharing, DMA or access
performance.

For example: this function should just use calloc().

int
hinic3_refill_indir_rqid(struct hinic3_rxq *rxq)
{
	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
	uint32_t *indir_tbl;
	int err;

	indir_tbl = rte_zmalloc(NULL, HINIC3_RSS_INDIR_SIZE * sizeof(uint32_t), 0);
	if (!indir_tbl) {
		PMD_DRV_LOG(ERR,
			    "Alloc indir_tbl mem failed, eth_dev:%s, queue_idx:%d",
			    nic_dev->dev_name, rxq->q_id);
		return -ENOMEM;
	}

	/* Build indir tbl according to the number of rss queue. */
	hinic3_fill_indir_tbl(nic_dev, indir_tbl);

	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl);
	if (err) {
		PMD_DRV_LOG(ERR,
			"Set indirect table failed, eth_dev:%s, queue_idx:%d",
			nic_dev->dev_name, rxq->q_id);
		goto out;
	}

out:
	rte_free(indir_tbl);
	return err;
}
