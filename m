Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EBEC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 22:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53A8A4027C;
	Fri, 11 Jul 2025 00:09:03 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3CC8B4026A
 for <dev@dpdk.org>; Fri, 11 Jul 2025 00:09:02 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4a9b09ba106so17049601cf.2
 for <dev@dpdk.org>; Thu, 10 Jul 2025 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752185341;
 x=1752790141; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTijQODxgcw734IKjRqEHG1NAP2aiphe0gzKHtxbNo8=;
 b=zSJcu/wMq1tpnNIa3vrLPLbgapJu4nUKzxDbmN+kDw5mwGFhVRw51Z2pDOj0Fnh68K
 AJt4Pbu7X3S0t6cZ8YrwQyA2xa74stJuoaDvj3RwdsEs2z64pLy14Zk7dirNt0jfIOWs
 RsBgfKv1nKQjMSzrbILgal5Nx69PGDX6291F6Yobag7/mMeXfm1u/IaOqzZWe8MoiXp8
 5cqTirJ1QXCFXsFy/FNL3lg+rzeO4HbsDrw/4HDXICUJ/+ylrkNj3MniCvzudLKxbKd/
 Um6+azwuHMzNmcCAZVsRftF4l/Y1xpgBAddchHvUhuTg5slKwh30hCzaCOqj4CWc9XEI
 9lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752185341; x=1752790141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTijQODxgcw734IKjRqEHG1NAP2aiphe0gzKHtxbNo8=;
 b=gREgFKRYH6gJ1OAUdtxoaX2BI24KLCUYaCu2BAW4RekXm3lnoc3EZjg5SrlLDYQASF
 dtQtvblcyWLZv7haeagv3q9d9dLsHjinBxiHxMAQIY8DDtAmZoufRfX7debQUPIqYiyk
 wxfsZLi5+lKYMACgaGl/jC+c4BYTwFIdCrAMhgCOR/yZS1TvBDDjH+kYTSlANfvwBxUx
 ajghgVDIpGkKrOaqF3fYskDowvA45swE1/ln6rQpPJABuUXHS6HEPeI1Ax9MkZQHaOST
 SeX6oja7thBHe7dUfmGhrFTP/v8EQBzg8e2slrs+S08XLuSFYZrN0/INYdgqzJLxNrX2
 CLsQ==
X-Gm-Message-State: AOJu0YyA4c6/G/HuvxfCJIe6cj/Q2tTFYPJuzYNBxLe2aAxLyKvTYbLM
 b1xWda0NUu0SLhTpN/I1YOjHjmDTqIf7KfwHrFByyBjBcEMPNpIkHEl41VhXJt8Unys=
X-Gm-Gg: ASbGncs0sDKY54q6dsudUFzKDJYUrxg2y1i8oQlToe+hL5oE+A6Gw89Ij7ndWr9JvhG
 ruCn/ftCyCCQjKUlPI/24+lENVx0rXt1NE74qXvvIXccedhqzu8k2xkB70hW74NrkDgu9eNMlJw
 mQE/qBD9mZ+mXYG+C/Du+2p269EsOMyzgy43KLmqsQb48Si3YZ6IRt1hSWd4LPRiXczAwBqPndS
 AAjB0mISdZVLKjlwnHRMP7ifovLiscKwN2szjc8nMC5UIaO8WIyzaZ9wpIv+fcBTG8WiNWpaws+
 hWncmA2dDzv7lMRYCfbbcM4PY9qHD+1yNuBpJzwhNCwZyWromQ3X6+8Q75yxNGQmLuG3LJpi2BL
 0q7ZdF9Z7yZPD/I/X38qOJo5ge4R4CS7dHV/0Z4CP05yAWdhnPHX68VkYtVCn9GVgd99mV0jUQi
 U=
X-Google-Smtp-Source: AGHT+IEKzkAsgV3RxhEys1hRt3dMtuIEZmEfj2M33wfPZB26w+k9gbuDj1ENXquii2/zpAsQWtu9OA==
X-Received: by 2002:a05:622a:790f:b0:4a6:cee6:9743 with SMTP id
 d75a77b69052e-4a9fbfca78dmr8535161cf.5.1752185341263; 
 Thu, 10 Jul 2025 15:09:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9ede76d5asm13924491cf.45.2025.07.10.15.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:09:01 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:08:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [RFC v2 01/12] ethdev: allow start/stop from secondary process
Message-ID: <20250710150857.564cf7dc@hermes.local>
In-Reply-To: <CA++2-x43vKdvZ0KnJtzAPtYdOcP9JsMQYc1QJVmBC3fFjnQ=TQ@mail.gmail.com>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
 <20250709173611.6390-2-stephen@networkplumber.org>
 <CA++2-x43vKdvZ0KnJtzAPtYdOcP9JsMQYc1QJVmBC3fFjnQ=TQ@mail.gmail.com>
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

On Wed, 9 Jul 2025 22:47:05 +0500
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Does that means that the RSS of the secondary application can be also
> applied to the primary application, or in case of multiple instances on the
> same interface ?
> 
> Best,
> Khadem
> 

The RSS is different thing (that is part of the config).
This just proxies the start/stop from the secondary to be done in the primary.
RSS is a function of the hardware (NIC driver) and should be the same in both
primary and secondary. It is still the case that configuration needs to be done
in primary, although that could also be proxied.

