Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC7CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F1D140E1F;
	Tue, 16 Jun 2026 12:27:51 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id D041740E1C
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:27:49 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso2047104f8f.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781605669; x=1782210469; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMbFf7YhI4nBT+MQ2TYv+/x+BOLc4faWoHRvr2/BQ/s=;
 b=sxtcrHeY41rhJfmJQ+3itaKXBKi7Vhrvsew4LkxxlccOzSCZxMhqo3am7QWFJ5WDQu
 qDuGwnugfhBRg9Y86xzDjsJFWb3UCgZzwIQBgVE13AaQSrDW0Ya6Pomr5UxL+vU7yxOH
 KfANBDtkxtTquVo16JkWSKdkOxE+XuIEgfdf+WEZTZ5yhKz43R9Iagq9ewACpNbhS421
 HcOJJrjJgEQWhzlCquco5seYSgWnh787kGVe0bwNzljDxoPyMY1+bMLKWE9iYdMBE1Vz
 cH40WGHLWQRFXRThgOR9asqWyc7CkfjZhYurGlQZQdt6DvUOEFeUaS9vyKOOMZ/TkDdA
 Nn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605669; x=1782210469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMbFf7YhI4nBT+MQ2TYv+/x+BOLc4faWoHRvr2/BQ/s=;
 b=qipWXFDzeo3NNtO1iTgFFbWlLunsmVJhQv2tHga36sGWNsxiV/UcHShTJiJSA2SHvY
 LkmgLQo0hWHOCuOGEMTpYFe7zDMbDvArEkKCMIEt3hzZP5TQlNK+UEOUdMWypqmyXsZW
 GibLlrZTrXcjHSNvRxJCRI7ALqyA+eNUUlbWCVDvlM2AM3SgGH7DmNkB+YyjtINAUAgl
 HAVehLarw2xm9tTFuq905sE/CVdiy4jOBpHXW2D0p36jQA2+UyBUlvjfXKbYP45Z5CAv
 1y0e92tMT7UHdBVHPlyhgOI/14Eg6URmFTusLBlwnqsRg2bLpSdPHksYrixDsZqTG68S
 lhkw==
X-Gm-Message-State: AOJu0Yy2PzV7fWtctIh6d9SzATph9ukY9hpoytR4h3w/dHYCT6ttY/q6
 Nt0XtARF/hq56T95pPYa+6nDeeL3D+cjtR6JPEXcqJf0GyXHZ0Z73cAlsay4XBTk
X-Gm-Gg: Acq92OGuaMGzp+90gp4YgRJP2Le9ZHqYp6+8pl/RUeaWoJagRsuh7ApO689gfkIipC2
 AWYv0oS0oXjH+J8OUZflf+pwKFKSS2nP1pjl0D6yGFGHufJZMh9B3tnXIG+e2XBJN2YqiWhFDc+
 s4L5+EE+TpXcbOI2I6ye8Krvb0DhIxaTvAvLttSgQtNCb6MFy/KrwRoIWbxBha7WW6hMKMj7K+J
 ntLfDbl95O2OEmZzEsouI5QZJzfZLj/5vPm2Fcj7qAPCaQvyuf4P+IQ3mTG6IB3+C5DPDzTWLax
 IdmAf3jOoxPllPwksa+zYHVwiWYsT4x+XRtSwQ+DaPMpX1hBYlPoj2sE4SmqJ8oaoSfvkHVlwDw
 FuOIqzXetDkAlQDAxx8IaXX4UAILu1mTZwfHmIzHiE7HeJPH4EWYUuKcAumkI/k7Keh6UM6lNTO
 LDCSlSEXn8MyqxCL83IO1f1BM19DJ5FRr94lQoeAc2A479YwHzNAkL
X-Received: by 2002:a5d:56c7:0:b0:460:3a90:b2b6 with SMTP id
 ffacd0b85a97d-4619f2dfe4amr4213705f8f.11.1781605669165; 
 Tue, 16 Jun 2026 03:27:49 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm45951639f8f.5.2026.06.16.03.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:27:48 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v2 5/6] net/dpaa2: fix Rx queue count for primary process
Date: Tue, 16 Jun 2026 12:27:25 +0200
Message-ID: <20260616102727.708948-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616102727.708948-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The rx_queue_count callback was only assigned on the secondary process
path of dpaa2_dev_init(), leaving eth_dev->rx_queue_count NULL for the
primary process. The fast-path rte_eth_rx_queue_count() performs an
unguarded indirect call in non-debug builds, so invoking it on a
primary-process dpaa2 port dereferences a NULL function pointer and
crashes.

Assign the callback once before the process-type split so both the
primary and secondary paths set it.

Fixes: cbfc6111b557 ("ethdev: move inline device operations")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 76e2df6167..ac7303c116 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3410,6 +3410,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	eth_dev->dev_ops = &dpaa2_ethdev_ops;
+	eth_dev->rx_queue_count = dpaa2_dev_rx_queue_count;
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE)) {
 		eth_dev->rx_pkt_burst = dpaa2_dev_loopback_rx;
-- 
2.43.0

