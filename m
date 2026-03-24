Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C4F54AC6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 14:41:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0885D402BE;
	Tue, 24 Mar 2026 15:41:53 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id BB22A4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 15:41:51 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c0c955a481so5631663eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774363311;
 x=1774968111; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yvTnkaPkbVQaRONqQmzWq9e1H/vhlyGG8PnsEu8wgQ=;
 b=L8ks/huBrwp4z/cVDTgW2lpUHEMBwKkltiCifxtN07uX1mUQfWvV1VYJjhVrfDclds
 wEScRM76uPmDDOcff7nRenrGDhT9BMC+UjlbBTg/Ndm2k89hK6pjQZx4NPaOA640hn/x
 XnwBAhsTHyf/Yk8GRDyRfh80Epb06I7lOD1pmFku8F3+Q94Vo5vydsL/eVpwpSM/FqH/
 GY0ZUpggXwCKx74P6i0YoOaZw/3lLbOxo3yTHT7KKUzyee7ijRsi2ej7Tbm92XJcKZSk
 mfgbNSCsTW4wq3ogJCNcBZIvXdu0jZF+x3dKc1KLsZfzAxe2HRfvl4+Zbmta8dHv/YBN
 HeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363311; x=1774968111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0yvTnkaPkbVQaRONqQmzWq9e1H/vhlyGG8PnsEu8wgQ=;
 b=aD4RjArcnUOm4q8CxHaUeQg0xbt6lIYr/RbvkN7phsMP5qHSonkNnvI9n4l6suAeyM
 i07fvPXFHBawlqYejWZWDmcf1Z0aLhKhAJkdkCZYbWYMyJ3XdXNA1pEBo+HSGZKjYRxQ
 pT167LwnpA2dnwPNlGobObD9DB7b/BvWAI8X0Yz+ePwm1iN4+34RlFo3kxcbATo/g5dt
 vmIubJjwpmIZQl1YcdVnpToUmozOwuTfb4EVaY9EBkQd2+s9i1UZsTKuTBmh3ar2fNeV
 rx9FuFi5XZDgw9a92a4qJQ2RpjNJz7riRqpRUf9LnAYT7jxBbZsSMBi2lCtFEJ6Wtn49
 qCiA==
X-Gm-Message-State: AOJu0Yx9q4slnfl3q45pOKbUM1Kbp2+AqoisflKkf1NpX9wZk9O4n0ky
 KDP2xtJnJokiO6y8LlqiM52HLFn0gbCTWNfSOyxkL5m5RegdWK/w+L21ACbSWGziyGS24GsA7uO
 xAbT+
X-Gm-Gg: ATEYQzyKP6RpdpFt46cFUK01Y1xh4GCQHK9A+qYaksyWEHIs7i4/OFIzP8QGP6Nyn36
 6s3kL3YW2lViaXWRhVLHa5LXtVpKHvxHex9DkAIS7iWVog5mqWMT5VK8EXxCAG1t8qZj+Cro0bw
 Q0ociXG5NuKBV6WyGfi9TA7WH7DL89HOveT+j+GPpgj76TzF6nHad3aOEyq+ud9LH0lEMUx1Rxi
 s2wAO2iZn/mbU4pjEspm6mI7MD8Fdy2DakSWuONcFdwf9tOwPFJh5K6ZymH4BFwRgjxCbj+bzJC
 qstghmRga90CFcTgA8fxEHPaFsL3DC9pFM8x63lDyzm2m75G31q132cs3KqXUyw9iioFijbXzVg
 aax2aRhSAXOCp5E+e8ttLB70CjjpsldjdCkd2u+qD2+M09HZqR1yrQOJqkCbLDVL05HBfsUVJI6
 SeRKQYkZylKsDoMGLi5sxMe3wzKqaxG3W3yiE=
X-Received: by 2002:a05:7300:d705:b0:2be:142f:d48a with SMTP id
 5a478bee46e88-2c109784293mr8669601eec.27.1774363310459; 
 Tue, 24 Mar 2026 07:41:50 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b35116bsm18419377eec.30.2026.03.24.07.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:41:50 -0700 (PDT)
Date: Tue, 24 Mar 2026 07:41:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [PATCH v8 0/7] hinic3 change for support new SPx NIC
Message-ID: <20260324074145.437604c0@phoenix.local>
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

Applied to next-net
