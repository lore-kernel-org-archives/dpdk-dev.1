Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB008D111A8
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 17:57:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC7740E1F;
	Thu, 27 Nov 2025 18:57:21 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id E166F4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 18:57:19 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4ee2293e6a2so8972021cf.0
 for <dev@dpdk.org>; Thu, 27 Nov 2025 09:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764266239;
 x=1764871039; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R07g9ltLw2bx5fpQSwSAZhdohZ9hmlqCPn6syEqQ1RU=;
 b=g1ZXXDPwp0WDwZulAsIoxuXphDAOqXTmAeW3SrWLSE/QWPrmNFF+Pnsqj1lJYL5jRC
 AWj0pfPS2cjk0tXa+cH2OugMfcia53ZeYkCvfvR8VWWUG1cuzkOt6+IafgkhgxGVt+Ju
 yJGsubnyUclg/VhVbubkK0L32ScKqcCSMhveIiaP7u2Iw8Yf/SBnV5ZmonlJtLuQuwtl
 RFn30T8JE5ZpVywnQuCezqAf3+G3C0wh0PdbnzCMLxp9xMU9fwXuBU4XsnWqB9NlZ/j6
 kZhXsgTrmaytAS8yJF9oiELti20mB2K0O/4bc12bc1i8bZKI6RBSdVXnMvjaPgH/5xPD
 uC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764266239; x=1764871039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R07g9ltLw2bx5fpQSwSAZhdohZ9hmlqCPn6syEqQ1RU=;
 b=qMmUiihKV4NmsYqQeUUQZqPeuip59edtURVqJqWjVLzcP9xeLNoFXq+mLKJ/pzK2tk
 T8zr9aqmYLpNy/0CJJ8iFg4I21MmQLM3NEjGhScVztsR/8CM99xmXxnf9LpkbYDYuNdK
 8F3NhiEjJZHphvyM5O8nMJJzjT+tgHupoOZOUd8QBFiR5udRvZ1zyh2BwS66IaRVg6yK
 G/+8S8DPiIvifKhjSJ2Zde5IAIKlVFOx2z1JpSk7GQwtnNiAx56B87SCGQ22VdtRXQOq
 N/iz4SWZnXghPD5XHbSRmrFmrt0brcF4tLo9+rytw36LNmCBlKZsA4FBay/RXDyURCbd
 Ss5Q==
X-Gm-Message-State: AOJu0YwGP3HY3Qf2SWZWmMJncytyNtd9zzkAAmvbUyYKCnnei7J3gDCA
 LjOyGklHUXxZK5uY36ENkLe/Cn5rasI1FXL7Yp1RHKpE+l1QBMnrJlVWLvS4vWNKvZxN7ye1Wll
 6gj6P
X-Gm-Gg: ASbGncuBfL+T9MOQ1X7WPfTGh8dGKju48Xj+0NcDacB+Jh3RquhZ9j5SW5BCv3nIgQs
 op47EGeNs9rwUGlNTLbqTvg6CwEJGvc/ehpcXh4U5LJ/Wrwn8BNWi237vYodLkucqcCe6sxxA+k
 qTnGC7hZp2oGyPDlciZLDZgDk4EItsxDaFztnu+t7tsFeenorZKX1XyedcXqlB+s+pVDB6koXOY
 nVjTXAPFk3zLiZMdcABu5dgXvXuUmnVERHbzOp9mwTwcNM8X9bRV55B7Go06ny2g0eYrxQoZaMc
 y+DKSHLYGWflkCzVpDxiICkVGO8EPTw5pPASA0Y0Uj1SASgUxmaTG+Kkjdb44lDgrW9B0n6HScd
 9MjINrTN1AFGr3rdXH5L1HH0LV8ug3dTx5jhhMoeWcUJEpr6ja6vYizoQv8nXmFwOKPSmm59BfQ
 fwNNf2UvsJIaOYP4R5D7sEnWl91RVbm5lJYD+XWoadwm3yUAMELsbO
X-Google-Smtp-Source: AGHT+IFY1MGhtKGiQex0cufr4zSXbkS6bem5C3eQhMU9QKRt34dmrdsZy7BN2NOP7nL5t3g9BePA/g==
X-Received: by 2002:a05:620a:4048:b0:8b2:e513:6419 with SMTP id
 af79cd13be357-8b33d4cfb90mr3150810785a.48.1764266239130; 
 Thu, 27 Nov 2025 09:57:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1dbfe2sm147473185a.47.2025.11.27.09.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 09:57:18 -0800 (PST)
Date: Thu, 27 Nov 2025 09:57:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH v2] net/txgbe: fix the missing old mailbox interface calls
Message-ID: <20251127095714.6b4f0213@phoenix.local>
In-Reply-To: <9E296F0580980C92+20251126085649.8665-1-jiawenwu@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
 <9E296F0580980C92+20251126085649.8665-1-jiawenwu@trustnetic.com>
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

On Wed, 26 Nov 2025 16:56:49 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> For different devices, the mailbox flow between software and firmware is
> different. There are several mailbox command in the txgbe driver, but only
> txgbe_hic_sr_read() was changed to use the new flow.
> 
> It lead to other mailbox commands timeout for Amber-Lite devices, which
> is required to use the new flow. So this patch fills in the missing part.
> 
> For the sake of code tidy, txgbe_hic_sr_read() should change to use the
> locked function txgbe_host_interface_command(), and this function could
> be change to pointer in struct txgbe_mbx_info for different devices.
> 
> Fixes: 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---

Queued to next-net
