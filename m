Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9274CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 20:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B02294027F;
	Sat, 30 May 2026 22:05:42 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 1C6A44021E
 for <dev@dpdk.org>; Sat, 30 May 2026 22:05:41 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-91550fe1619so13563785a.3
 for <dev@dpdk.org>; Sat, 30 May 2026 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780171540; x=1780776340; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOAliQEKehOielf67P4GdnK3HfBj5fKy6QiXICQWLME=;
 b=U3NLk6O9zFmEcPhAEezoQkv6mimSnBU78doxbMS5mVERgwfL/5kZXexi/y1IfXoPzO
 sg9SVlAkSTPvLUACUQQAZz6q8/xFqHH6YQ/lQigcSBpzS3RLg//Jkzt8nosqH/8Vv7cK
 +cJu3N3196h0BrzT0XgPIo9xB+ufQ+tPmGXnKdJa8nRCnSKK7Xl7Sa2bTEZhXCPJj3nW
 fmZGqiJXaVJR5J11L+uO8wOw/g+bIek/1K637iiEtEsNaB1wmNP4Y5nXvZFW3wwzYRr5
 CUTgHwAzD8vY9Rpl8aL+PmbbCnMKLW+3mlktWVCP1oGQr7cShVmdP8OQoG+a/7G/9x9u
 E7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780171540; x=1780776340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KOAliQEKehOielf67P4GdnK3HfBj5fKy6QiXICQWLME=;
 b=hDvPrpXjFNBMHWcgtvRwvnCprtq2AncHvnPMVjkByH1te0xa41P93OUidW+VPEQJ1m
 7edCdKtLYBLYyL42S+7Z7awHNj8fR4G63qMIzFSe48RA9yKf6b5bg1Shdkw/sva0J5in
 MKTK6R/UwflSePmbtTzvVt96s4WZb9Mf3HoGoGOMZJ7D3qtOdFz5KT4O6gNOicCxDjgr
 +SaUx62GwWp3VNzlwt9aN/+IEWvUnXxsvyp1hhANtuwaBA2XO7PDFRv5bj4lfJJDh7i0
 IBGyFMeoB79BEDWoFidl2cfLzmkRrjtsL4BlQC13D8F0fvAym5Z6MCid96JiNoGuptUz
 Xxow==
X-Gm-Message-State: AOJu0YwnvADCqInBx6jdBUAeafnrcMajWsU+s668PSjRHAePNLG5/qzr
 4LTVUW9N20vmZ03Kt5/YwpeTAjSSuxRK0j43w0dN/bZeJTtM6sza4mA7
X-Gm-Gg: Acq92OGqUKR2TSBUV/ObS3zu6TtXLW/0gAafkums+3/9we9aE5Z2nCcX+tVyy/CX3ug
 aDaL7JKiQv1wB9+ynG1pZqg26OrDpORjN1wLJfGln87X/hiL+/v0KJXT+5XkPDYG0H8xV4wK12i
 WZdXWGjUpYE2h1MoJCsM+LTLWj9Qz05eUYbcffnp3aBFSjejo7zjtrZGklry49h0vcDCXiAtBRf
 PiSbEm2s5L/F1V88EdqqyB04u23J4PJg4D+8vDuGWzbM2cn9Mdi5sknjSjipRx/bRgorhFQarLw
 nyUkIbQCuLoI5nNcmt6LqgnIYLy/+OKpn02MErMMpMoCI8PY6rEFPARVhOks8g/xNi4Fs6znLS+
 D62NLPLWzg+xYPQofjeGOc7kVnb2zBQ82wZd+qUqBTG20Z9ugYBOwnlAVv6ohGMU3GQsHARM5I6
 AwPQ7yvrmLgR1kTpE2hhptVbydYr6BKxlg8Qf46I97gNJU9j2qWVscVxWYRCfji51T0fV+LvnJm
 g2tyYkV5o6UEiugyGRHpNfOK2hGgx0+c6pNIwqa
X-Received: by 2002:a05:620a:c4d:b0:914:babf:9f45 with SMTP id
 af79cd13be357-9153da1f461mr794287285a.26.1780171540280; 
 Sat, 30 May 2026 13:05:40 -0700 (PDT)
Received: from blam-mobile.hsd1.nh.comcast.net
 ([2601:188:c083:cd0:c107:2c35:5b4a:5cad])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153247515esm567569385a.13.2026.05.30.13.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 13:05:38 -0700 (PDT)
From: Patrick Robb <patrickrobb1997@gmail.com>
To: abailey@iol.unh.edu
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com, probb@iol.unh.edu,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: Re: [v8] dts: port speed capabilities test suite to next DTS
Date: Sat, 30 May 2026 16:05:35 -0400
Message-ID: <20260530200535.18605-1-patrickrobb1997@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260312185330.226227-1-abailey@iol.unh.edu>
References: <20260312185330.226227-1-abailey@iol.unh.edu>
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

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
