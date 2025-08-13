Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0ECA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:51:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 502AF40657;
	Wed, 13 Aug 2025 16:51:45 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 35A7640265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:51:44 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so35917245e9.2
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755096704;
 x=1755701504; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXdWxIgzDnMgX4QX6UmtSt/0DIyJS5IaYXeyiOogaqA=;
 b=nDgIVaef7Dg3RmNthldEwrY9oBJFksX83ul9qhz/HS9uAGCS/Gj2drM9N/6EG0DRJO
 /crcIe5Qt6T8yVDTiJMkHpyP7BeiB2A4omcYVkP0jJ/84TQv/nZrRvP7R6Qx1FTHwc/n
 HF15qdTLjGY2I5kq8CZAlWf9tXqKIW5BVJO03dpCKHwZU8+bnifvLsvdkYszDNtvrcte
 fcrNVGou1Og49sSDqmLE9BDk10kV39Diqr8Y2DHY8ihxl8/e4xI2VVD82CMveoWFga4N
 dZOmZRzIx+qbCBzli+nflGVenlF+QJZu9n7lNUH3zcDgxwBfnYAHB4V/Pt2KUcfdNRTi
 84FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755096704; x=1755701504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXdWxIgzDnMgX4QX6UmtSt/0DIyJS5IaYXeyiOogaqA=;
 b=V1GeeBAsTI/vTSq2v0YVo/F1FdEOBB25OCAg1iSM1Uy5uPDWJPqFdUHQX4uP/qJ64v
 IcZatWzqpFMokOSo8v6lp5dlN5fBDzwnSJw05uacZEkeOgC3a/UR1pumgtmYNHDa5tFV
 Jbh0wok2u9p9TmCeCS+mcoCffr+V7gD/1Yt3LisbyseeFkpcKk8hcilFz9nUCV8PK7qc
 UGl+C5rxaJXqsc5XJcyJNwqs1QFupkD7T+/gQYNF9os7YCsuqBC8pE8mUSn9iipbU0BQ
 5vH0ISZRg9QKzFuytfpogvppY9iG9JM5B8NogKFby5hpDCUeGDhJI7kdDzWj8uL2YPDl
 1wTg==
X-Gm-Message-State: AOJu0YzAhuQzkbC1LzsiTDbtJXykB62DkVdJiveyFITsWMNcrxBVr1tm
 kO2OrlJyEcw0Biwt8+9i42S5OCKMDo5E0MkdQglZgv2KdhQFPk4pXngcjRZuiyD+7Ms=
X-Gm-Gg: ASbGncsmMA4tR+lnUF+ns0zSiGV21l3AAh6yhVK39Jub6/ObvBPeMtH8Gj9+Hr/pHqL
 erqXn31Et0O9dPAuUtPZNsrw2ySzYUHQtOKEkfQl+lcA8fY2qVcy321+15puKyCF6YOdIHUVbsE
 s3+rzcjGCVGeooycKWT/040Sz9fRUPpfgB5jfJu0NiQwcemg4vM+oykIjqcHGNtx6oiu3kQI5Bm
 pKqxRPqRRSqHZhadbJzjGyYfUtOpMmbqDzxh2s/Omod5ApxNogPdOOGJCbrk1uDqilMRcNCgcp6
 O02vBJSWn28koknrfxo9jhaUAPn/MqV6bvkN3DuobJu1YVB0zSWGE+tHA+mjfMuj0/qZAqy7I/f
 bp+URbmjCNjgML8YRai76bshvxuBc0sQbG7YQs0I+k+8Sh1p0lrywa1z3MMHZFcTvmuYPdkhBrW
 c=
X-Google-Smtp-Source: AGHT+IEReKiS3pgJMt/7/X+ZRo3x34to9dDSjDGm0dAupbF4y7gYoTNiY8+NYS+J/Are5nA3lAoK6A==
X-Received: by 2002:a05:600c:19c7:b0:456:201a:99f with SMTP id
 5b1f17b1804b1-45a165e2e2bmr32204745e9.18.1755096703636; 
 Wed, 13 Aug 2025 07:51:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2187sm49651989f8f.70.2025.08.13.07.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:51:43 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:51:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH 2/3] net/hns3: fix unrelease VLAN resource when init fail
Message-ID: <20250813075138.0440576f@hermes.local>
In-Reply-To: <20250813073317.1352274-3-huangdengdui@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-3-huangdengdui@huawei.com>
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

On Wed, 13 Aug 2025 15:33:16 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> +static void
> +hns3_uninit_hardware(struct hns3_hw *hw)
> +{
> +	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
> +
> +	(void)hns3_uninit_umv_space(hw);

Overall, the patch looks good. But why the (void) cast here.
The compiler allows ignoring return value unless the must check attribute is set.
