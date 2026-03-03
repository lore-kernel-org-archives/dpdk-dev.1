Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F13EDEBFA
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 22:16:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20095402E6;
	Tue,  3 Mar 2026 23:16:10 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 0BEEA402AA
 for <dev@dpdk.org>; Tue,  3 Mar 2026 23:16:08 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1270adc5121so7830522c88.0
 for <dev@dpdk.org>; Tue, 03 Mar 2026 14:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772576168;
 x=1773180968; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDbKqpfHN6rbSN5FdLdydx6O1s9vy+bbRiTTXcoNDT4=;
 b=F7fmrBfoHx5QTOwkRFCfejdvHL4eDZ52SpfqKohTeUTDsvrwzEOK6RlyZKjZTT82pp
 YU2t5YVF0PIyrPJYQc1tGrUOcHh+NiEYvMQiM0KAmqfiKsi9JavqLYyl2ZijikGRWfNy
 KA7Syj0ZNU3zcD8+4JCQJwUo5Yh8L5DKf+pDVUQuBRVWvrDAuQQoCrrAeQJjfGf4ZUPd
 wU5/4ySdZhli27M0Hq3hWDvG9HNZNe40pupysonZgxU9OLfbWo4r/S4dUZ3WZrNZM4Nk
 ENnfDiP9GLJoWx+ZhYgpF+hyzSgv+MomWClJqubJa8LsQE+zWb63oXYZAxa4EAnkWnrg
 nrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576168; x=1773180968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aDbKqpfHN6rbSN5FdLdydx6O1s9vy+bbRiTTXcoNDT4=;
 b=U/nWZPMVfF2EBqAO08mzf4z3cPNwUEUbR8/uexQLLoF5Q2OhNsEmbJjIUxpS/bzypB
 OYsLzC59i8Z2b5spVQFovZBEbEgN9GbkESTSvrMb70l6kakmRmjeYkBhUmbcmCGgeuCT
 05eJWAO5KjCuKGNw1H1/2YNpM9+DVOfCvKju5BdwTcpDPyzfjOXNb7Zo4mx1EdERDXnH
 UG5Mwz+9/TAd4molcoX28N48G8O8kNDbyfne0awTKdpt6hsLrGYtFo9M3ol+YI/LfGkE
 miEhiwfq+twmFifu8Lai73gvtVEneR6w+DBsehZtqtUfz18P9I+gOAdc1gD3hXuqCAqA
 I5Tg==
X-Gm-Message-State: AOJu0Ywpxnej8tahNDCP9avdBlNqNFKSmyOcjKsSnb49SfkWxnTwwqpK
 X9pAK7N+Xl18OuCLxghLQloPt7h+4rucmpPfmdzMn7cysp/XrWvtIzytC7D0KLg4xy0=
X-Gm-Gg: ATEYQzzUzl0HW7yLh6mjCsJZoL3IKLu2BW7Sho1zo6cpDD2tHT3qbAps3kZOjB8xkDQ
 3jaSneD2OoGC5w+7F7QfS5zbYjyykyf6CJ5XV1yyDxlXeSmTEqk0dHQ9HNlf8gJA/FpKEqSVrVJ
 +0V7dCWiN0fhYQGn6gupejW+ZCFrAvRx4uterJBnkbqWvsZIX9PNjeFMmPf/bVCMpuRP9AQFdS8
 iOj0gbYWzkuVNzBzyjuehbjfBhdQquBMYZer6ltRFx6c/X1ht3LVhbFYiNYxfIlHPCFUlEPSJ4h
 t1Bd60V/wlQQoM9ATS8ffoCRa4JRz3uM95kgHooJt73vScSIM9aKq49+EEfYf8r3ZuHkdbaVnnE
 rfDHrPyTMqNvtkr53XOIWQZxxtfV87Uq73vPEGwQ7b/AWgz8v2/C0fN5WZ0IzPlLcRe/U1N9qRc
 dvnjxYoAYxtQBtSA6oWkvPQbhtvr/mYnceLCmAYVl2zOFVy4nHm3HJZ26Qg4bPoX6a
X-Received: by 2002:a05:693c:8151:b0:2be:2b16:b99f with SMTP id
 5a478bee46e88-2be2b170190mr447670eec.13.1772576167744; 
 Tue, 03 Mar 2026 14:16:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be2ae7a2f5sm970051eec.33.2026.03.03.14.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:16:07 -0800 (PST)
Date: Tue, 3 Mar 2026 14:16:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, weh@microsoft.com, stable@dpdk.org
Subject: Re: [PATCH v4 0/6] net/netvsc: bug fixes and runtime queue
 reconfiguration
Message-ID: <20260303141605.02edf0e7@phoenix.local>
In-Reply-To: <20260303205411.325585-1-longli@microsoft.com>
References: <20260303205411.325585-1-longli@microsoft.com>
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

On Tue,  3 Mar 2026 12:54:03 -0800
Long Li <longli@microsoft.com> wrote:

> This series fixes several resource management bugs in the netvsc PMD and
> adds support for runtime queue count reconfiguration.
>=20
> Patches 1-5 are bug fixes:
>   1. Subchannel leak on device removal =E2=80=94 subchannels allocated du=
ring
>      configure are never closed in uninit.
>   2. Double-free of primary Rx queue =E2=80=94 hn_dev_free_queues() alrea=
dy
>      frees hv->primary, then uninit frees it again.
>   3. Init error path leaks =E2=80=94 hv->primary and hv->channels[0] not =
freed
>      on failure after allocation.
>   4. Event callback leak =E2=80=94 device event callback not unregistered=
 when
>      rxfilter or vf_start fails in hn_dev_start().
>   5. MTU change path leaks =E2=80=94 missing chimney bitmap teardown/rebu=
ild,
>      rxbuf_info leak, stale subchannel pointers, and VMBus channel
>      close before free.
>=20
> Patch 6 adds runtime queue count reconfiguration via port
> stop/configure/start, with full NVS/RNDIS session teardown and reinit
> when the queue count changes.
>=20
> Tested:
>   - Queue reconfig: 4=E2=86=922=E2=86=928 queues, all transitions success=
ful
>   - MTU changes: 1500=E2=86=924000=E2=86=928000 with rxd/txd=3D2048, no c=
rashes
>   - TX pps: 15.5M (1500B), 6.1M (4000B), 3.1M (8000B)
>   - RX pps: 7.6M (1500B), 2.7M (4000B), 1.4M (8000B)


Looks good, applied to next-net.

PS: had to argue with Claude to get it to understand relationship
between queues and vmbus channels
