Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF42C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F22EF40651;
	Sun, 29 Jun 2025 18:45:42 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 454F14025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:45:16 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d0a2220fb0so189209185a.3
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215515;
 x=1751820315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pcew7vPn27mKBbWWT/visy/Db0n3iEqiWbzvSdM1y0M=;
 b=dsksgDLGNQi7O/RMQM4AKwTuuL0zM3vSeL7eMylRKaKpI8LuB9IvvVztolezKIcpZH
 x/rMCngu+eGOJItjukDzmFfxBloDuU9XeE7I8aOn/qd5Q30/fPi37afzhDL48rOZg+AU
 jM6xh7fj74uy+ghnhk8HvN25HOpJbtwLbIvnVH9uHZgj6KWDaSC/jEvRssx4M3ifsEAC
 kMZa/xAwoM5HZCDaDB60jsPIjAJN/neMx6EpUjkYbtigs3k+BIOFBCsAz+9TYM4JMoMh
 /6Yf/pG6Dj53mLq6Tbe822lf392mWCNRzbNeJ9l377+fSInvzNW75CATTI2hXO6HmpZQ
 mEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215515; x=1751820315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcew7vPn27mKBbWWT/visy/Db0n3iEqiWbzvSdM1y0M=;
 b=KyKYudyY+kdjJ2ms/4CX8sceRfvBGxRQ/INSCIhd14F8uKrA2D+IuTgDJr+klYOxTR
 xODTceFNRDamURf1nhc2tum/6eP970ReLaiOaYqz8+SEgDc2uNKS8i5d6X7RRB8eIVpH
 PJ7AYROyV+cfvmypoOEj/GizVUca89Yt7/82R5Av/ImjG+Nfoz0jXxkztZNd1Q5xx8pq
 g4jejn7ltxZCtq2kqOvJuiTp1tJc76oKR9tYTg2mEWI+N8DsBu3Yu4mWhDJvrj7piLj6
 6RV8AQquC5H8LmIAzAUk/OpcihARn3cM4Lm38OVOKfjpu2hymiHuqzm+AZevoVqtZdvA
 dkFA==
X-Gm-Message-State: AOJu0YwI8X6C+j+rr2WqTbkCLo1T7lXtx5YfRQ+0fXl5XzpQWbRkvP+J
 z9alCtx2h9ChvsFnsGNEDVTro75+neGX+2DaFRqZtA1kBP9IyusSY0LYFvuco7ASR24=
X-Gm-Gg: ASbGncvRpMAcwtNWG401mPwnp1fp2ZDNw9LVVB2yQQCvIFr+zBiQWvCeeD273CPi6rV
 9jC0U+SBO440zivRWDP5hURJKDP7Wr9qPtng5MbUzltyEUdqPFgHS6pq0v1NNB3C1Cmn5v5KRrA
 xrmYL71pnD1uo3E9ONs3XiO5+SXGIce6rjdP6PpzuWVKBBCbeP0JqVTIfrtxU6cDA/JX8iG6MXE
 n7tqgiqU33kozSC+ptqPxMrDDxGwiwxsDyEQpsBcrkItXM1jS3cUOM6OhrN5TD5zGfHFu9vNB8t
 iU6qtC9CxxuIb9Wf0QlRqQyhBo1Q7VgiDjzUUqrdNxY8xd2X/pcjNvUJq9Su6AnRxIBOeoeC1NG
 NnIm/v2/xxehD64z23qxSuw3KFOzoTvSFjwYlGWg=
X-Google-Smtp-Source: AGHT+IGDc6unhXSDnos1UFd58pp0eIOcLyDaloqELRiQCsm7811CFQjnZCGvx2bW7JiGAi/6ytrHcg==
X-Received: by 2002:a05:620a:1a1b:b0:7d0:a096:cf80 with SMTP id
 af79cd13be357-7d44395460fmr1287725085a.31.1751215515688; 
 Sun, 29 Jun 2025 09:45:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316547bsm456985385a.27.2025.06.29.09.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:45:15 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:32:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v4 02/10] bus/dpaa: add FMan node
Message-ID: <20250629093210.293e8aea@hermes.local>
In-Reply-To: <20250611071039.2939950-3-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-3-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:31 +0530
vanshika.shukla@nxp.com wrote:

> +	fd = open(FMAN_DEVICE_PATH, O_RDWR);
> +	if (unlikely(fd < 0)) {
> +		DPAA_BUS_LOG(ERR, "Unable to open (%s)", FMAN_DEVICE_PATH);
> +		return fd;
>  	}

Would helpful to user if you added the errno reason.

	DPAA_BUS_LOG(ERR, "Unable to open %s: %s", FMAN_DEVICE_PATH, strerror(errno));

