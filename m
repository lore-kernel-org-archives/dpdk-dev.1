Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE4C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 15:37:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C20BC4028B;
	Thu, 10 Jul 2025 17:37:53 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 63738400D6
 for <dev@dpdk.org>; Thu, 10 Jul 2025 17:37:52 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7d21cecc11fso203515685a.3
 for <dev@dpdk.org>; Thu, 10 Jul 2025 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752161871;
 x=1752766671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lucxKU+3jVa79vLHVbhDyAD8Z8vJK3DxNs1ecdvhuTE=;
 b=p1j+i+93hrUNlyPF3S0lPG9SvjSpXHGNhHA+GQ/UEw0TpOhhijute7qtoK5Lq20PyV
 hOOw6oCxRl9hq6SmgnW8hc3e5gEWM1mSILKxhQliTC+4S8CURxWpVP6FBabzBs7+bM1B
 c91ru4N5J305InT+LgeKpvqFbpWqJymLhYu0q8pO4hXyVHC/sfyouqEQrUkVPcxxv1HO
 NMkHsg3k0PROn5W/vAEf3eAfz/tbxIm6N7pm/PXzTeFWQ2gJbMT6j4ln7uV2MQ6qhDFU
 QIMu5aK8LQ4qmNfeQibvA969JfpvbdOhbrXUtZ5f6+ZR/O95EfYmQXdElcFAxC5IgJfJ
 QDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752161871; x=1752766671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lucxKU+3jVa79vLHVbhDyAD8Z8vJK3DxNs1ecdvhuTE=;
 b=iZ3Uvlcw2GM63FpLOxJySOok409gFQnXBk/8j3lr/mQ1nMA1iVUvy3a84HBqH1aEBp
 aVJK85zaSybuGIhiFQ3lk3gv9OyuzSaqAqhgzZK7gckso0PyzhHVkLu75XKawJ4upaIM
 xbxVvp6HNQyDy/nK9Pdty2r9m5n09T1Mvd8sjEIeZB5JGUvmsj6H7bEnqLm4cZBv3u9+
 qZMvsgkWm/47n/+A1QwEUmkDsInHiJ8Ti6b51p9UutKX8ApylXALiA8ppUJpgPCQWrrk
 zaOv82yVxCmcmIbTrdZzv5/gn/PYfIAhUOdBE4urxuZqu2WRFfQBsCoPQISJvEDP9/Hp
 mHPA==
X-Gm-Message-State: AOJu0YyYCkrKKFYF9K9Mh/gXZHpLRjsTp/Bp2b5XxX8DhvO6JSYpNTCg
 BN9c3se4uudOKcq0tbgVeLMFtwm0qTgQ/gZ55jyVUSBzc4Kwjh3DohbFVnU8sQiupj0=
X-Gm-Gg: ASbGncvtKO902DYf+j/+RHRbXQ+Pf0wPE+2RvPV+FHU/IRETIyJlLtumR+P8fixnv7d
 Enyr8MPL599S2oWZ4QSLr9PIj7zHx1YbqRtCes4aapkqBXtMjuztvZTcHv3NFMQv4lM6NPrX+7X
 dIWsw96FAKz5fBzGhtMlLgqmUDg9z/AVQZ/28j/ApIA6shC6TZZXPRJUZyfe3oc41MaPxLlIdF2
 vt6khNO3kxtztTjm64XKkY1CL3JTJkMskKqHxwc5Sci8e+le4R1tuYj0Qie+i8Z3bbxYPOGY5wf
 TGjmCITARYpnOJ5a2kZWheglYJaHU/vneCOoplLh0D2yN9MQ3PmiKbkjAWXu1WVNtV6gea4dVHi
 WGBOGpYvskHvj9zClTc16/3C4EVi6upRVCzmvfcs2RnRilrBR0g==
X-Google-Smtp-Source: AGHT+IHmKvdDd9EV5rm5QsNbMkYQCh2tD1hZE0lotFo7BKcYRDLarcOYUQHwgnAe9GQw07lpzsxmmg==
X-Received: by 2002:a05:620a:2490:b0:7d3:c381:f653 with SMTP id
 af79cd13be357-7dc9c29c74emr521062585a.56.1752161871574; 
 Thu, 10 Jul 2025 08:37:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7dcdbb1dc64sm109964385a.6.2025.07.10.08.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 08:37:51 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:37:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <hofors@lysator.liu.se>, "Naga Harish K S V" <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, "Peter Nilsson"
 <peter.j.nilsson@ericsson.com>
Subject: Re: [PATCH] event/eth_tx: prefetch mbuf headers
Message-ID: <20250710083747.6f613e7f@hermes.local>
In-Reply-To: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
References: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 28 Mar 2025 06:43:39 +0100
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> Prefetch mbuf headers, resulting in ~10% throughput improvement when
> the Ethernet RX and TX Adapters are hosted on the same core (likely
> ~2x in case a dedicated TX core is used).
>=20
> Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> Tested-by: Peter Nilsson <peter.j.nilsson@ericsson.com>

Prefetching all the mbufs can be counter productive on a big burst.

VPP does something similar but more unrolled.
See https://fd.io/docs/vpp/v2101/gettingstarted/developers/vnet.html#single=
-dual-loops
