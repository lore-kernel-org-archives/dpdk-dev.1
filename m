Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957D7C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:42:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CECA3402B9;
	Tue,  1 Jul 2025 15:42:37 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4F72A40264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:42:36 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d4495753a7so373006185a.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751377355;
 x=1751982155; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dobj3i+FUE2CpUfudH3CYDfxTZrTPpPPc/oNTykYCA=;
 b=3NLr5dwqUiGp7Q5zbDxBl8G+2tb0RXHIaTTkG98F3NTQfk43FH2WEl1NdhmKxrhyMu
 qcvdbrlnr1AhhhfEmTTWEv+8O1xPRGCy78I1Fii3ZxnUwmFI2Wuf3EhLhrW6cv9Mssr3
 /ADOUeKs4eWkxjBgVkDWhUzf0w1mZTwUldJfuepKn2AXSnBL+Ojz+86/2eHo2Mbtz2yN
 SS23+RXGvku8G3/BU8pnewzrLDn/gis0sRAnKetzVp8Xt1P8HU6j96V1FUD/yfgzhEca
 pjulLcS5bJlAaEjdoZhb13SHR4a0NJjbYFlM5HTU27CT3ZTylFXlqrtuNqm7Ah9XRvlF
 NpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377355; x=1751982155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dobj3i+FUE2CpUfudH3CYDfxTZrTPpPPc/oNTykYCA=;
 b=FY49NBmeEwNK8g5IjwNdpSvCKmNAL9nPvw0R1cUygU1PyljYKaeFdfyR5Q8bm3XJH4
 q0DnrCkOKtkwTt6BuLD106tMtk8wUAx2sAFTHRJF2gXl/xktAmIkbqLYii8SzvBwEeDA
 +tMNuWY00zTHikhs6rCFJVneB0+g4oKp2bZrZBPofb6PhMh7flQalOdoljHsqjNw5nE0
 +/o9yrLfQWh5KQMP8hU+ZvMFmgvC0sw/nKxv5snQN96KBkhsY/iV3BloDOhOulCn5+42
 toKA6GhCtc3azNOqe5svyElYIAGT4rVTKmOS8xw66hxQZxN4YN3rppggnXou+GbE9E/s
 D3uA==
X-Gm-Message-State: AOJu0YzUBClhdptKuf7Vo/MNYpPXpcE0ku5uM9mS+Q1Z4cRFrs3QPuT9
 UkXsKOpmI5FflmLK+zjjw4M9lcWCT5V+E/zzu7abyLvtVmfsjLD78i6sbhuyVbvWCnWf6BSVN75
 Ts9pdn/M=
X-Gm-Gg: ASbGnctf/eCFTI4HYDZFrPUZYRq0mW02cFSV5BvODoXZbeyQ265Mxlwtq08EDH+8N9Y
 FvYT/IhE8MYc686405VZFI75HRrnjrD3Qwwrp64KLKLgWr8j6XF45OKkfeDlOKCsW8gX607Nnz5
 NY8OTOAPXEmTHJsXcF0XB6mwH+ThRuDRwW4InnWzGUo18rZ8bYON7SjytPNzwH1y6NrkWQ5Adv+
 xwxA5fxxZwvYjYXftsTZJ2sRsRpMhfsqpMVUSBWKT4EEHStqfMW48rzs3zJ4upVgX21jf22gVoM
 /rt/mmzBNthxkhzTUczoqWnMJqLI4DXNHszMp7YDUENjd2Uj8ADitBs2s24YGNYTLTKvHmObF3v
 gen34FCXhr3fdHAVHa2nPTCn3HL9sNrgPsvH0TQ4=
X-Google-Smtp-Source: AGHT+IEzJIIHMR11AWa0s3pYXW+Xuvw+lmtQwQKi25tLx6VlZ3EXwqeL8p/mAWFOv1qzN13ZqhdTOA==
X-Received: by 2002:a05:620a:404a:b0:7d3:a61d:9e4d with SMTP id
 af79cd13be357-7d44398147fmr2297283985a.45.1751377355442; 
 Tue, 01 Jul 2025 06:42:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d4431344f7sm773071485a.2.2025.07.01.06.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:42:35 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:42:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v2 0/3] net/ntnic: implement start, stop and deferred
 start for Rx/Tx queues
Message-ID: <20250701064232.7af2a323@hermes.local>
In-Reply-To: <20250701102027.3525524-1-sil-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
 <20250701102027.3525524-1-sil-plv@napatech.com>
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

On Tue,  1 Jul 2025 12:20:24 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This patchset includes:
>   * feature start/stop queues on HW layer.
>   * feature deferred start for queues.
>   * Improvement for memory mappings when IOMMU is unoptimized.
> 
> v2 removes unnecessary log and adds fixed tag to the commit message.
> 
> Oleksandr Kolomeiets (3):
>   net/ntnic: implement start/stop for Rx/Tx queues
>   net/ntnic: implement deferred start for Rx/Tx queues
>   net/ntnic: unmap DMA during queue release
> 
>  drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  58 +++++---
>  drivers/net/ntnic/include/ntnic_dbs.h         |   2 +
>  drivers/net/ntnic/include/ntos_drv.h          |   4 +-
>  drivers/net/ntnic/nthw/dbs/nthw_dbs.c         |  20 +++
>  drivers/net/ntnic/ntnic_ethdev.c              | 128 ++++++++++++++++--
>  drivers/net/ntnic/ntnic_mod_reg.h             |  14 +-
>  drivers/net/ntnic/ntnic_vfio.c                |   3 -
>  7 files changed, 189 insertions(+), 40 deletions(-)
> 

Applied to next-net (for 25.03-rc3)
