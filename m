Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF8ACD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 18:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DFB9402D3;
	Thu,  4 Jun 2026 20:24:10 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id D32BD4028C
 for <dev@dpdk.org>; Thu,  4 Jun 2026 20:24:08 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so1801367a12.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 11:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780597448; cv=none;
 d=google.com; s=arc-20240605;
 b=c5MSnVqWkJUbbaBo709anwHGWPSTcgbv1jmVw1oR2+tmcFbd7mMLJPakfdA99yrD0N
 tR4fVjnasElfId72zxwu6PipNjtycT7wOK+DJqVwoaQyVDwfc4l++RkXbDza4oJj+WvA
 Ex6d74VS/jTCYE7OnN7cYLq9bXMXI1Gb48bzFf0Btqk//pMC3m6LJz3HIo03M+ltfg2y
 YeMY2OsadDSF6X4iON69Rq2tkQhhnGa76TJSRkVlJ6hldLF1WrTtq3JJCwSqTKts/+nw
 PreNQ2KOJn4IOuYdX+aeH2k9GbK9U8XlbphGRmF+5Y19wDqI5iETXa5UwTBz9yD/Yqnq
 uMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q9FOSwYMPwMn8WmoSdbwi8eIps5v6YvRsM8VoyOF1Jg=;
 fh=oMHtUs+GhEpKP8oXXT4p10biI/Zcr1VuhNQFcOwKP+A=;
 b=dJzxJlDQ1KhpEAo9xlgQP7eYGTO8EQofwEji0Z8ZEnNt42V51TxVUdywgptttCGfek
 r+FlWUzZiJX02UM4mDaOeCld8U8SWLjFGwmWFXxhNCOITU0erjiXy3BAVfxK17GHEgbs
 fyJErcVg7z4wLJOK0k3gUmTCjiGkfnVgXe9Xs85wHw2SE8t2eZEo5RpQXOh5zMdc3xiK
 0OycM4lNVN40wavXbarqcbGx37xaqtRjEIQ8CznUNQ8OzTVFOECnGSa0Gp7jNUwFA+G5
 wmhfQTlQXuinlxEg8jAihXNMZIku9kecOUHiYbFZiVzxOpnxXOD9L3puXC0BNp2mg/Vt
 +SBg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1780597448; x=1781202248; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q9FOSwYMPwMn8WmoSdbwi8eIps5v6YvRsM8VoyOF1Jg=;
 b=R6uXOVraeXVTSguDnTDtpjSnIJ6ibvaLEFrgvZM38L1UoEFtjUSxFTk1MiwnwdZX0D
 Wzz4AnXNpYgm06JIL+7hO3q+2km4pA+tbte3Sjg5cUB+2AOs7xA326fz/3h4XrTeqI+u
 wOKqQSjiIjRFf8qbnd7meoRsFJl7bcXFWuhn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780597448; x=1781202248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9FOSwYMPwMn8WmoSdbwi8eIps5v6YvRsM8VoyOF1Jg=;
 b=iGYFu5AnzVGnimVZr/Ss4yCS+x1gNjLjGUX/KZ28Eug0v3RLCZa8L+ue4bguVsuv5u
 10fAip1AnQoUk4dMrJchgflLO3KuBs7743jfUQwzKxUpBRULdCkM1YIhvCoyAaY0IG4R
 M/+MvVU6UvIs/CsjtNAYl3cwcG+hdsdv31SYb71featS0J+RU36JMTeOAXp72JXbc42E
 2FydM9Zr4NhjeaiSFKBT/aSmPUCEr/SkyQBrTpvJhk9xpaVE3DK0mpbkUkRLrnO994G3
 OIAc1BiVjRobDHAU61Dkp7EvMxOlVXgQrlnGRGy9L1pu3+7y/G8zEDCmjVezLdSVzaFf
 Xx8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ioh8aCGey+BNxqlHqOiLt5tNSS1X2DsarMSn/EAekYPJ/X70AxlONoMMVG84ZvzWOoEk=@dpdk.org
X-Gm-Message-State: AOJu0YxetBon3FmhKoYi8uVET/k22Mrzd5CU1/RIfiEN4xZf9iVg5BDA
 M7kBn71k7hnIborx0rH9xu8J63jBYXs71fsxrwywIXuGrCNZmmG1zFaFzIILAQPYcRjJmgkzDG+
 J4KKXXHl1UnCJsJsdXfXm+5rY+488u2WP+t5OX8sQAQ==
X-Gm-Gg: Acq92OFPV30ZAl8CwOD5xtmyLL9+MSFkv18DVROKwrx2VrHyZPrLBh/68tCydwsEYdQ
 20/rsAO30+0fAyQGsIYc2WwBj+n1svbxjh1xZYEfFG7Eh0Y5JWbPABHulZA478KSNAYtLUIpjdK
 oAnvmivn7b3pOllS0VW9ipxktpTzM8eR6rsoGnvO9Ycjuv4yWTIzVuYBE0kVP1eJSWckX6KnM0r
 kxM1DLFZxQxMyXuJpG2N0IrISktdJcujFh2O4HX+2vYRsI1MWnVg8D2lq7/zOFRADuGK032J8/1
 DQAKSQgKzxG3mGqaatFDBYrOaY7pIN9I/LqMdUyl9b0Uloshh0yx
X-Received: by 2002:a05:6402:210e:b0:68d:d511:4a9f with SMTP id
 4fb4d7f45d1cf-68fa514d599mr60359a12.18.1780597448401; Thu, 04 Jun 2026
 11:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260430192911.297180-1-knimoji@iol.unh.edu>
 <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260522154637.952588-2-knimoji@iol.unh.edu>
In-Reply-To: <20260522154637.952588-2-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 4 Jun 2026 14:23:57 -0400
X-Gm-Features: AVVi8CcF548IyKo4kVI2bVBG7PIn2m5eGVgpK484sqQGg9_P1RNklbX4sC3SzXY
Message-ID: <CABJ3N2XT3ZU54pGXw_9F9AvtJbGTsQbrX2R0BE_RYNNQMRiLrA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: add build arguments to test run configuration
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000066781d065371a691"
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

--00000000000066781d065371a691
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-unit-arm64-testing

--00000000000066781d065371a691
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: iol-unit-arm64-testing</div>

--00000000000066781d065371a691--
