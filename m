Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D03F54AC6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 14:42:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75E94402BE;
	Tue, 24 Mar 2026 15:42:45 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id ED8BE4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 15:42:44 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c7667af6f35so11700a12.3
 for <dev@dpdk.org>; Tue, 24 Mar 2026 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774363364;
 x=1774968164; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFURR69v4UmV1pfkunGkx3ELvjQUb9vc/wpvQa9Fl7M=;
 b=CbzUmnqGwC2n8usNBb05w6nQX3D2hDLitzhwda0fclKHZ58A+//8EJGuUPaSQAxA/1
 xRRexzfV5Feejo//vFmjK+ps47dr2w1lQRAUlDI0ZmWpD5H0s/WEtS2xnOEHqJOPodLf
 iRZKJuUcG29c5GvLFv3eO/RV1XgCV8D6V5cBK5C0aqJsMOSjeCe+nzo3bwnU3raqnxZY
 afTsm55FDXrnSOVLKhHoVY2j9emRwjON7kFyhZ+piXoiB/G72QYVm6ALyHZ0OKMlaNKK
 b1E+6C89SVbEQUPcg4i9tBXED+ONXYXclKKoSNEsi+lVQ1n5PFt2J4OobZaGj8rs6ttH
 GWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363364; x=1774968164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AFURR69v4UmV1pfkunGkx3ELvjQUb9vc/wpvQa9Fl7M=;
 b=E87PQwiWvwMf3v2yrQNuYLGPJGc61ZYXyu64wv7/Hq7JkB33TCJU6pTbHWdqTHZkwB
 2mICn2qhNsT0n9fObMGa/BWxCfHOssGt8Q0p6R/l3dS3MH9Ued1BQwaE5JN8wg0t8RDW
 LgW+SkErKpKJFjOwcAeoginhAVZTyU26BfPLkj4o+lprQ1uNdPgPYlvrFSQd4FT7HodQ
 MQ9AxXstj6f0QQmAHfFWtEySm0OMUNBhxqu1GIx+J0oB+V9JzNnb8txReem4hrgkf6Ur
 f/loFJvvt+6syUN6SOxVMPhZkvnWmeiaZ3UVcgplqnZSfJrU1oBywMzJ0kf0IHKBGnjS
 Rjdw==
X-Gm-Message-State: AOJu0YyN3XRvDOBW60P/TuSjF7GnTo8NhleuIRyCdMJ4f1DTDWGvV8G9
 ppMIqSMhQOj1MTfzX0StkJmEYmDIlokQo1N+NPOQc2WBoz2TueP5viMCurJkZB0LvFE=
X-Gm-Gg: ATEYQzyPIrMD5zgfkdiT4WvmNYqhl7WbpZyUK9IkKYUKbPhJtiXcFkgcfl/xIQrTvKv
 LxHT3IMadD3eWRgpeg9V6Z2KDGbYZAY1XptYOuclhwOJN1XCMN2Rc1/8Ty/HK8eFzKi6XGKNzvC
 a/Iz5o/vsksi7FMMGV22yvxYlV9sJioGDs922CsRsVYWb4iG39R9JrBarzdPJZ7xegjbEjvGnGs
 9jPWkv02e7PXUfDtoFiTy7X9XethSUHj4unPiNSZuns23u2TIBWCchtMMdLz1vx+w7ioqp/UttY
 g14Ui1viThigMdtLR6S0iJJCFXWtgUKiGsG2sWSab5LlMwfVTqsUnPqAW1EO/VPlM9to9fSWio9
 zf/gROB9PvvJU4QATcqmCjFs30FaTmsnH1iNScMNc+7Qxg+TXY9oTm/ghBBKo8kqz17fTcTyGec
 OusUo8SrF6MAyE2WvIfToJ00MwwLa2teeRnPY=
X-Received: by 2002:a17:902:ef45:b0:2b0:9aa7:9494 with SMTP id
 d9443c01a7336-2b09aa795c0mr72853475ad.28.1774363364048; 
 Tue, 24 Mar 2026 07:42:44 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366b5besm150140805ad.55.2026.03.24.07.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:42:43 -0700 (PDT)
Date: Tue, 24 Mar 2026 07:42:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [PATCH v8 0/7] hinic3 change for support new SPx NIC
Message-ID: <20260324074236.613d2f1a@phoenix.local>
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

When merged did small changes to Subject to resolve check-git-log
warnings.
