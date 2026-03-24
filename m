Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9264BF54ACE
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CB47402BE;
	Tue, 24 Mar 2026 16:17:12 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 92F664025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 16:17:10 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so1639810eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774365429;
 x=1774970229; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8tt0xepNgyEfRqRshKAkdKvubVdz9mEcq3K1aE1v58=;
 b=kX4V7BmRgf4FYYmYQAzVHvfTvvL+PUReCoDLxUL+QbY+Ee/RD3qeqGAdMs6dGztPA1
 YIdSuEpVksB4JyiAaWdIUApDwgzk6bS5bwtZhGd5XwCL1pqiGvMhHWXnGGjtt95PXqnF
 z07WM3e4BBW4cnJGOgc+QGb7iFK/CEdmqXQ398X3aFj23ZwfG3kA9WkcX1BXHgMi6kG0
 HzsuhsC3c9e2iTsyLQuLbLyp0/uMlBAKTMhrh1Yg3ydWE1CEHfJkcqfnQwec4hj9WllM
 u+SlTj955Q+NQkiM9pd9dTR3oF//39jxB+VhZ0N1mgUmSmfv5Ah4B5Uo3h67aGHSdV7C
 jx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365429; x=1774970229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h8tt0xepNgyEfRqRshKAkdKvubVdz9mEcq3K1aE1v58=;
 b=Lx/qR8A8PZy/VvzfXx87GMZHdtpkHd0srtww3menqwcAeCBvP3wuMb37b4gIe5XlyS
 eD8GbzPOFA985lapKw49qQKehqJ3vvsmGZUJlEVaHAhHwCPeTUn8HcV1D3+V3cw9YWKU
 0RYgfKw02uYYKT/++j5K++QSGRvizMUECpg9aFeTvojV6+9B1TVGZWprxMhGYbtpBj99
 T65+032CHp6C9Cm9IbS0cKMyuGIaKWxniLvPmIPXBRIxc49rFH/xJXLXDCaFCpYUr6K1
 VnmGx3he0FFc0fl5WigyYhbtqrhzAAPeDBkK6bKz7PykkUBs9dEq22yldmKb8Kks9L31
 Ue8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCULkPy9LTCpyr0vUy0JJ0G9HXvKs4HXaP9LXKNgRzGrNe2e6fW0YHDYiNGSaJjvS53gg+U=@dpdk.org
X-Gm-Message-State: AOJu0YxI5iLaZzn9qycAL020lVtXWLRY2BXBsEGlMOykknB6/KyrvKF5
 ZK481jZDuC2302t8ZAV+4K6UGScy2C0+ffGY6vUacQEcba3MlsWy3mC84JdObKQn3uA=
X-Gm-Gg: ATEYQzwpynfonAAqAZ8RKzZVnzeYiQKVhry5fAh6wrJVmD0bDUEHJ1wqCUx5wDcYyUe
 Iyfx53Vu13hsuvU0uKuX6U215sa698FiWhQOGfFEGOY8OVhScfuP8Bh9HXrLY4TM7sClKpoXCqR
 DVa0/Sq41woL2tdxUUu1dVZAHoSzIVf7NCULdv3gM0Phr0lVeMLIeWKxlB9FDF4tE+hrfbE6x2W
 DgZff6boso3oTcDRwWGERppcJOR00lA1WEQmNTBm3k9ZUeCdTQc5PcCE+9U41joNPS7L1OLemJN
 aOJk187tUtieQ5YGIwPEfm1QclsC/OA7f8aKo4mF9RkpCiibuIt1ByfXAskRDoSTr+SIv+GWOgp
 Mo+5XzrKmT8K+o5gHfO1MKtkROUXjhXOYxqv21AecqZOwv/NXgjcbjwDFkjDoMRoyJa44fneW4V
 Jkl0rOMNtrjvltjkUXNTpUS9TvmmTIvZpmCUg=
X-Received: by 2002:a05:7301:e24:b0:2c0:c7cd:1288 with SMTP id
 5a478bee46e88-2c1097602b4mr6825021eec.27.1774365429409; 
 Tue, 24 Mar 2026 08:17:09 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b1961a2sm15834856eec.12.2026.03.24.08.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:17:09 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:17:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: Re: [PATCH 2/2] app/testpmd: revert switch domain mismatch check
Message-ID: <20260324081705.085e4a9f@phoenix.local>
In-Reply-To: <20260324123709.3471-3-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324123709.3471-3-dsosnowski@nvidia.com>
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

On Tue, 24 Mar 2026 13:37:09 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> This reverts commit 8ebba91086f47c90e398d7775921e05659c0d62f.
>=20
> Previous patch changed --rxq-share parameter logic.
> If this parameter is passed, then unique share group index
> per switch and Rx domain will be assigned to each shared Rx queue.
> As a result the check for domain mismatch is not needed.
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

One nit from AI review

Clean revert, correctness is fine =E2=80=94 the mismatch check is now redun=
dant
since patch 1 guarantees ports in the same share group have matching
domain/rx_domain by construction.

Warning: Double blank line after deletion. The removal leaves two
consecutive blank lines between the variable declarations (int ret;)
and the if ((rx_pkt_nb_segs > 1) block. One should be removed.
