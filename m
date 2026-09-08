Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB56EC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DA3840691;
	Tue,  8 Sep 2026 16:18:55 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8344B402DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:18:53 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc1c7364550so4827901a12.1
 for <dev@dpdk.org>; Tue, 08 Sep 2026 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788877132;
 x=1789481932; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tXjWUC7nPJdkMMtHnEl2wNqnYCKWt76zG3kQYw6er/A=;
 b=VVKB/O9Ualhzof4sBcknhvNW1rpYBLtL7706+GC/kNQAiEj52yNePc7NxC8Q/iAy4q
 OqDceEElx5HXw3TERB8N0CViF6YUiHlTH8fjGgQjSYT3NvWljDZq97GovRC8scNKDgUG
 +LAIIDMDzDXVF4pffAPBoBGjOEzNnjz9GMC7r3d6xVtmuFvRa8w3UtFRfW5myuO4jPlg
 +gYE0wlmFifZWZtr70PGjWTAlMb3C0NZiON5y1vlMjx36gwSDB7JCblYyZKLuNYH+u+k
 K2YJQahXv/lpMDBQBGvOWhkw7fhV9DN3eKWU6UB5wVRzySqn+ck2SkS0m76VfgWWbR09
 CmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877132; x=1789481932;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tXjWUC7nPJdkMMtHnEl2wNqnYCKWt76zG3kQYw6er/A=;
 b=PpDlSOJAfyWk1qUz+oAZG2rJvEozaSrCNZk317+hbEE3tJmTBOuPzD/JM481uPIL9t
 U+iP1EDU2TLogjetfpzvncqXUKKvD2gwwlMdC8AJPIGUwdhWceo8J9LKblaZbJijESRN
 /fFpSLCHhRyCx+ZFdIx/iQAHsWw+OXOxbzxclNGQ7YGqpEw3v3RZlxbZDJkwypwfkX9I
 lRET+msIkAvQS+WvqhYhtQ7zG/eHs+v+cEfx18n9rJBJJNhceuKZEp3QdsSrUqYVZR6H
 2tMsBHZRSam0tSPIZK9C9TDf8u1Jfmpa1MVI77L+aAv7hMUaNsFsVwwXerV277EspJbH
 UHEg==
X-Gm-Message-State: AFuF++nXhrvZeJvYu7zjO5i6YMNkI6vZ/yWEEXz1rAc+e9DLsZzFseFg
 iPRppKNSOigYbXPRtgW75xaPg/Dss8GN7ps6jlUqkjHvdQnCKGzUX/Mvdo6teXtazyc=
X-Gm-Gg: AYBFou3UMU0iqG0HrYiXr0vBRhUn5e7NKrX4svInjZPihDloFx1DPw6rXp5rZGpcVsf
 xYaiznsSK7eVOQtXDX+l1Kv+xJ0Jy+Z+mWypBqbD1okX6hbgOhkiQlsjNmylw1xXrD3la6ARuzF
 ykqK7S4u0pBafs0D3WV2Mn036+Q8KIPqOh3nSfG857OWESvfrXkQVY1QU6LGGvkCBJAKD9fV38h
 e1qSHLCyHI0idBNMQq3Xriov9yqXlpOfWWkoLpuX5Wc0j/yyn9K4SZYpBcdCogrTTKruvpqOdmJ
 K50Pt79+3H53Nc4PFhNzcBeXanqq4EUAnFOX+kKwMR9rvR+XTdDmnvE9eAsfYbNXmdmrvetZ3Ve
 pszDlBLgQx1XLahqAW/Uq8xF8ppUiTip+ZKHtSY28iYI8gW4K7riHpXv7WO7MUx27ExbCvwbhZJ
 mR/hhXYphfsB0UdClOVKV+5m1i9FEGLz1xEWD9+zijxxToQ6vo4fP9HB7hKei+BgkJPLDffA1TH
 uVkJDNZEIaNWBFhAG+npa2UcoGvpA==
X-Received: by 2002:a05:6a21:6f12:b0:398:8870:b58f with SMTP id
 adf61e73a8af0-3da3a03ef42mr43977691637.14.1788877132359; 
 Tue, 08 Sep 2026 07:18:52 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc45542b36dsm5284187a12.14.2026.09.08.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:18:52 -0700 (PDT)
Date: Tue, 8 Sep 2026 07:18:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <hofors@lysator.liu.se>, "David Marchand" <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH 1/3] bitops: promote bit manipulation API to stable
Message-ID: <20260908071840.52cf1efa@phoenix.local>
In-Reply-To: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
References: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
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

On Sun, 18 May 2025 10:05:54 +0200
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> Remove experimental tag from generic selection-based APIs to test and
> modify individual bits in 32- or 64-bit words.
>=20
> Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> ---

These all make sense, added to next-net (for 26.11)
