Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43347C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:41:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EF9440270;
	Mon, 24 Aug 2026 18:41:13 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id EB9AD400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:41:11 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so3029514a12.1
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787589671;
 x=1788194471; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pcjedu504AuCsJdw3J9qNKZPgI+152aDCpaaBElwuxk=;
 b=XJl/O4707ijMwxQcI2ZUZQYPyjnRbhP6Z6Gr4Yn/Kv2imH88/2QwNa+BGhVw9UQYYa
 Rr83578WmyystlJIi1m31dRf4ABceh0w9PTbmI7IzCuvYQ/nBxnhwFkbs+A7vGed9xfT
 ch2hoqSx0Pjo0ymcCAKFHV8VhQU0sILhsLhAuTzNMfs0gbcim2dOcCMbvKSg1Fit/25C
 AyYgn1YaCb+qY1QBAHjCqRkcgp3Y7oga0q1HIrtnQmDf7dEwOLpdTK0KPzlbxSuhyLR0
 vGQ7q2pMbCmpqhlWCaBs91HzknbC+o1Zimvfc/hpUtn6u82Fzpp/s4BdjAxCOIaHJEvO
 6Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787589671; x=1788194471;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pcjedu504AuCsJdw3J9qNKZPgI+152aDCpaaBElwuxk=;
 b=E7AXgf6hX4xQYm9VDqvhWjY+VxOZICH7kyNH79yW5ZLxHGZKpyTOqRslU8hg/eo97/
 ynRd75hPq6Cwe/kv+WnSWq9/fgoJhxC2f6O/JV9SlzDnk0IU03TZ+I/KzXHjw4MyySlc
 RJUyCeCsKqWKpD/+TBv4OcrXHmMBRmeCveGo4zWQ4tK4xIVfmCsc265BKziGygowqixK
 d5RLMNgio8rVlk9rsjhMlegNXMA8FDfWYIC6A9+0DbzNYx8GanXz4m+GM+Lp/UGhGIE4
 hjCUrKchY/Tmuh7/NqK69pBs8aeYgLG71BZ+MI8evOdxIep390Lv+on/g6KBUvrLT2vN
 Fbvg==
X-Gm-Message-State: AFuF++kBCOHVkj/w97EXEKvj7mzb2iiXj+ANW2nlzBebtzE/TwQP9gyb
 aLeJ3d/x5O0yJjQibpdrHFc/hDmvU8e0CeC5OLjQyh0nBA/IpA4ZhBhQepf8fcOoT9g=
X-Gm-Gg: AR+sD11wqOCtVYWIk/qe2rhs+52oNQaIjl5KdZel2XdkTxAxT5aMn+os54xI0ck1mcr
 bJsIVzZIK7uRsKtpFFpqfphShznaqCD6QEkGr16YgULp8CpLOiuiaAtbvcXfB/k91rMEgs4kYBX
 0rxCSGuKO1yacalGztBuKgHsfUYafr9nCSztE6d5tSugUEH6Bdbe8wrhPZqwNBPkpOoCI4gHG2e
 h/4ve89muP/ZdxOMFeQfcmk8odQ/FRVVa7WAxhO9iidZ1wrmOFN3Effkz8xSUkHu1n0EGj1geRq
 YEAxkzmumbe5FYhzftIwkc9SJ3vMsulFoaegUc4/yoEg3DR1a7ibyEGG6T3//DhH/a4lZxfafEQ
 msYjQ/w3ny7hc5RliTCurQFFqQmtgNrwgrJv5JUH31lsdEKIWDzeNOoQ6t4HtKg+lWwKkTy7Ula
 Mn0UCbalaRvKN+f8OMP8h4IyUm/I8lDXp1Puzy/CEaZvoBwcF7ln1e9POEYimdjPNZb9ZPRhfRF
 OP6p41Ja5tCR47+KFJCHLlkSyPTYxvYnwKSPfjU
X-Received: by 2002:a05:6a20:6f87:b0:3c3:33df:4d9a with SMTP id
 adf61e73a8af0-3cd4b9ae0b1mr39425323637.1.1787589670933; 
 Mon, 24 Aug 2026 09:41:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc199e60ddesm1176184a12.28.2026.08.24.09.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:41:10 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:41:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <G.Singh@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v12 00/15] et/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260824094101.32d4e42b@phoenix.local>
In-Reply-To: <AMBPR04MB122819F9F9BA58ABDD22A114AE1A02@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
 <20260821084927.6e6aa27f@phoenix.local>
 <AMBPR04MB122819F9F9BA58ABDD22A114AE1A02@AMBPR04MB12281.eurprd04.prod.outlook.com>
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

On Mon, 24 Aug 2026 07:52:57 +0000
Gagandeep Singh <G.Singh@nxp.com> wrote:

> Hi,
> 
> 
> NXP Confidential

Please fix your  mail response system. This a public list so
any response like is violating that statement.
