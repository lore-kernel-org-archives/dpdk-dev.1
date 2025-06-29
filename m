Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870EEC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65C98402E4;
	Sun, 29 Jun 2025 18:45:18 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 377384025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:45:02 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7d219896edeso395561285a.1
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215501;
 x=1751820301; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyubFdjH1EJMs/Dm34Z6lXC7TUwkNFGQp8N0SkCPSjw=;
 b=uUyCRi1hBHdpWPSatxxdafqvcEmDk5To8DOlK4eWJsvX/FETKWfy8qGUYBQx5l0WGS
 kbyKezpZ1B9vF0cjec0KLVs/d4Y7Aoot13IRt/K6F7L4C6m3Nh+dL3hHdq/n06cZ9C1b
 qDl8/Sr2enii5otShM4864+LkcbSJj4COup2h/92ISnH8Hc0O1qhkIzV5cuAGdA7FtO+
 rwuJ1RgWtqJIDgzNHuyCrsRhisLjymDdsEXnTNmY7i6zHJYxA4z5e7S0XijhHQdFmxBw
 T2JEzeag6Hb1OhLXlQ2IbZuy1Si4i+u/SrYPLiqd1t4YEJVibZ+mPCoUltAI0EGUopet
 UcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215501; x=1751820301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyubFdjH1EJMs/Dm34Z6lXC7TUwkNFGQp8N0SkCPSjw=;
 b=ou/l4Mje9RUjlWwAMOgtsR9vc1G5c3SXKhBqnV9dkTWCoNyMBJgVX//Y+Wq8raU+bE
 sNiMnJ3b9YIKtJOHMZXfsWlJraiuds25z8nmBhvXYAuHIZgtccONeK6MRiFNcKUlK3wb
 5GY/x1Xch8ZXA0p/y/LygMC7vAu5bmFfOQ1qT/AE1JUYdg7TlGOHmGXtChxw8d4+2ks2
 ucbPQqG/ZiCHbJu153XfToBDdHNT4E2wjFsKXzrFIzMW0NIHBFvOJibQuVF+ViMQZn+j
 VLmHeHT3YWhCA1m4jBjRuXVNMahPqNSK4p9RMHs+6+PkImhdDdV+42gmlUudQ2byVsP+
 YTVg==
X-Gm-Message-State: AOJu0YzDXZgBnuQXv0tC8t0ypIrSHuZYlBRVP77ECK7WyPg0lCr9R04M
 fnS0WlKRgX0jnwkqezoytwioK8ofzwqhSwfmD4FL/F9Iq6lGRgT8sXWmkWg7mhhwA8I=
X-Gm-Gg: ASbGncufxiDSoIMZ6Eyw2Dos50ShA78aLZwWAqhvm/9+8X3KyumsIICzpNEwHJmpNfn
 hbhPS5DTxgJ9jmjVzcy09yw4Ykti4I99tNhcspx1XBg42Onz3l2X3jEhlZnDFqqkiRgsjB6Do2c
 iH+DZN4xCrDsQEWFTwiHM1U8kPQRZ+B/oHmjSKbvygVVakKxymq4efXbEB90HA29xZHa2Ss+DZm
 pcl6yPZmJDfgXxz+o3vW7x2LS0BQBqYYAq4td+DT1FZ58EYgQLEnYOBQXNC/DOZplar+DeQfNP5
 LZOaWBPBSDhKmkRK94FAvgW9odyY/8+AodKe5aErzi/XLTgUHODXcA1w54v7LYz/4eksKzU4a2j
 3M6+tGhfLinpoB2nmqH9QoU09ldHH/e519JP9Kx4=
X-Google-Smtp-Source: AGHT+IGytiGAS2fNEFD9DwEMUnI0VUg3k+RWRRqt1/Fxem1lFBnfqoAl51P5ZwjsYC5ZuOO8Hj2wUg==
X-Received: by 2002:a05:620a:4556:b0:7d0:97b1:bfa with SMTP id
 af79cd13be357-7d4438f5011mr1601313485a.8.1751215501559; 
 Sun, 29 Jun 2025 09:45:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316547bsm456985385a.27.2025.06.29.09.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:45:01 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:42:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Vinod
 Pullabhatla <vinod.pullabhatla@nxp.com>
Subject: Re: [v4 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
Message-ID: <20250629094254.450724d5@hermes.local>
In-Reply-To: <20250611071039.2939950-8-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-8-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:36 +0530
vanshika.shukla@nxp.com wrote:

> From: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
> 
> Add support to set Tx rate on DPAA platform through PMD APIs
> 
> Signed-off-by: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
> Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
> ---

You intended to add a PMD specific API for rate limiting.
But there is no RTE_EXPORT_SYMBOL so it was never used.

You would have found this if you added a test for it.

Not accepting this without a test in test-pmd for it.

And why is the existing ethdev queue rate_limit not a better API
here?
