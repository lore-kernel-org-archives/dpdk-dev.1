Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA093E98DFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 07:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34CB340672;
	Mon, 23 Feb 2026 08:58:04 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 39D3B400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 05:28:28 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so2356381f8f.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 20:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771820907; cv=none;
 d=google.com; s=arc-20240605;
 b=IZRU2Dk3S+T/5d8pVsoMtgVcyvPdtdjfzWtZ48iw+C9V1GN4hj8Z49sMLIBs44R5cZ
 HzfEpiMfB8FflXuOsQjb0DJ6QEZVa1Tcq/iDbfLLqYxQjvXzobIIJTcvVCPHmptvvR4k
 Lbd8q5zU3LxaI9v3uzU2h8i03s5oi0+BgNOWs2D2KURXqmJ+SbwibU9TYFjPFrzYAZRM
 yhVDTL43a7ieoUWWEFp/AfYGE+r1tFyrSwE5DnTkmd+X91Dp6OxdXBOagRUA8n2Vb08t
 1gK8GbQO6SoV7jw2fOn5LzrG8BqZp+eo5wn/W1jvwRwvcRDwzlCOj6e8Jl0XXFFvYfDf
 hcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qoZ6BSBAIOa5i+HiHwJSZtY+PDTlzvFYdqI7p8jneUQ=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=VkJfOoAGPthtxWnc9gjopsb4mBleCj23dVYiozu2XX0WiUbnCrd6erc6jdeAtUhwN0
 mfNQ1axYRBqPm1j2se4F/Wr9K0EaqVZKQQcdlP1yh8KCvuEEfagPXGMuQN2tn/JerIvy
 Cuhtk4ENTvqjF8N8knQwFdzNPvk59QycM+qbhcGkJIotEDV8T4H8eQW43T75c83fmJ5/
 b1vFY17+Z3auqjPof8XAxmL2vVsvDvDv6lGPSgeP+DjIj7VkZwrFHSXlxR/vv3PmmgHb
 8yuarOeZOFYjFqoIG4xiY/i9zWG5g2fTzzIFV/2gEatX9MsxoJnD4uO595Ii+q4n2icr
 5vMA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771820907; x=1772425707; darn=dpdk.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoZ6BSBAIOa5i+HiHwJSZtY+PDTlzvFYdqI7p8jneUQ=;
 b=W+3B9f3kJdpaohHpBFlRbgnxshaBk9j6J42IN6T7ZKQ5XfH3dfRjt3xd726hWjAMkp
 cHLHopR6p3BsJ0sW6q5FW5QEjrum3XSoQbJtSoMRhCmY14kmCfJHhvd6FLA8OLZ3E4OU
 GVHdC7gob2IjYN8dJA4zYNfa90NSyjpnFT9wH+udzmD1Nuz6ZxBkQ3LUmvFzjNzi26TG
 xZWVp5B8xxlCNZV0KVGCXaamqJ4BtCUBGE49NvHd1Xg39RPC690W2JevARfhd/HHJ8rK
 nW/f03ATozcIB6aaTjggMtWxAJY5DvFer9+TjA3zB9W5b3ooqNlqSA13/LEDIo6HuA+M
 HG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771820907; x=1772425707;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qoZ6BSBAIOa5i+HiHwJSZtY+PDTlzvFYdqI7p8jneUQ=;
 b=vKugveW2RmYkC1E7KVWyyzyMhQPYk/fc2Q5/rZ9TWF3UHiANIj4Lkr58I0jqReOVLW
 d7YpzyGiy1L0F/QRANJ39UjtFisum6JWPoKn8lkHLepLpkspWeN9Ac2+Ikt+bsVSXzQ2
 aCvgeu+IYrxnMPHA6ZCZsNjgGRTcG4vVHo6Xh4jnQam41m+ck8OQAY0JjfOsyWU+t7v9
 11V4mIFF0nRncRXZxPmRkF+3bJiqjIuDu6DX76pDFv8Y0aTiiNxPAJUOcNwofsDQKOyp
 O6etlnfScXlsOu+9Nv62s3ICE6taWxNeZ0BpVpd2B20o5qr3by9iLT80eYNkl/aylCDC
 /mfQ==
X-Gm-Message-State: AOJu0YzTZ0rahedrAn8DSzO0/Ankqp55LLpFcdx8TCYLA5S8dAMTL5ow
 kVlRH2l3AY1Zn2XHBsJUSw0BCCoDLOIHS035LsmxdX+n50Zmov83/DM9I7nCHyxKppCIDHTn8Ft
 aOVtq5ihcZus9/ez2Wan9JV1ot1U/bdYdvuPy
X-Gm-Gg: AZuq6aJnt3D8oXGgq2GMOj2q8ePCPEd1O5KRVKjOsMVzmZ97X/9+eWWysLeQIXnALRK
 Uz9rffYI5j3rxMVA1zydVlbw2KRjnQrVDbxHiAXdLngd/7eMMTfqVNnBuD9eWrP49naPMMBL2ga
 WBkvK9/M51HyO0DlB4zkRdelV//i3Vu+YaubUfeeXJAiTyOoThVJyFl7DuCLdUK+s+UsLsgwvNH
 0xrZF2/frHYP6VPGIDzN1XRE+hifw0Ulu521yquqcLkGVUyCnC8QxFgcX0tIsuAY/MJm1HpQ6L3
 X1vW8ey7z7sMMPwwEw==
X-Received: by 2002:a05:6000:24c1:b0:439:5bfe:18ce with SMTP id
 ffacd0b85a97d-4396f15ccdemr13341595f8f.8.1771820907292; Sun, 22 Feb 2026
 20:28:27 -0800 (PST)
MIME-Version: 1.0
References: <CAN33txETfmQEj8j=W4-nkUk1rAq0_JLhZuR4R-c3YCrDY90y6A@mail.gmail.com>
In-Reply-To: <CAN33txETfmQEj8j=W4-nkUk1rAq0_JLhZuR4R-c3YCrDY90y6A@mail.gmail.com>
From: Harsh raj Singh <singhharshraj215@gmail.com>
Date: Mon, 23 Feb 2026 09:58:14 +0530
X-Gm-Features: AaiRm52dhHH36zH_hSHpJpE75l6V9IYuXvvswQnWEA2G1Hn8innrlhawDLnNL-c
Message-ID: <CAN33txH=GJyXy+TyfPxPFrhLCxgrT11yZbMyju1B3vgq8YJ_Sg@mail.gmail.com>
Subject: Re: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example
To: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:57:51 +0100
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

do i have any update on it

On Sat, Feb 21, 2026 at 12:13=E2=80=AFAM Harsh raj Singh
<singhharshraj215@gmail.com> wrote:
>
> Hi,
>
> Please find attached my patch adding an ACL-based L2 forwarding example.
>
> Thanks,
> Harsh Raj Singh
