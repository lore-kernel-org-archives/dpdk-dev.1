Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36B4E83847
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 02:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20764402C9;
	Mon, 23 Feb 2026 03:49:50 +0100 (CET)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mails.dpdk.org (Postfix) with ESMTP id C8BD140288
 for <dev@dpdk.org>; Mon, 23 Feb 2026 03:49:48 +0100 (CET)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-46392972257so2535004b6e.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771814988;
 x=1772419788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmjMzZZ9KZi8XJxX7Q+Y06dy2oRH2j3KnRDdHNdL8xE=;
 b=su1noGo5ww19UzNkpsZzzhneSuI3sk8rc4mpB+OtCQ6e8zTv2iI4SRIuatuwICreCt
 rridjHsl/VSfLQ6wS1kFlB6OJhSxf5hFjYxwvKbfDAd4QCdkzUwioVpddXUIBrlBeNgC
 +zacfvIjP0YZ+HaGakKPck83cWRT52pFjF3LW3UCLjlxuBKxS7Oe51VYFGqhiLWVtMc+
 ddAN4ScbINvzcyFC26LTPI3GkouWRWdghVHiibhM2IMZ+MZwFYMoXS8b68AAATGg+Nch
 vWqHM35/zzoMxLLhZ7VOfpHs7V/GxN4XaIizSUTuxc4oB3UOzoX/RaOAEYW1auANG0OB
 lahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771814988; x=1772419788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmjMzZZ9KZi8XJxX7Q+Y06dy2oRH2j3KnRDdHNdL8xE=;
 b=UwBR5CgEWgKohh2Kp3r3CqkIfdf8dsyX2KIT4bzKk4+zqCCZeTOfXfeKQbSP8HGYng
 cRhZWHxcjSAWuCvdrwfoVILg9mboswRJ1CZ/frg9Dwzv/peVZnsA4fSOAJVjuaEjqKH1
 oJg7jeCQMoTsNYktPMhnzkmXbqVO5q9kgwlgt2CrV5mBm3KjFKkt/gIwRtmXIPzJeVsX
 9FkiEi9SJa9lY97kt+TxNl7XvEdKsIVyfGqJhAfJuL7itZs29ZafAPbSOuxzwodOMKEG
 7RORIALzHOGHwrGZFdXkibpz+3YywXJ4OWKZNC8xBeUMC4r9GqSS4fge87coOcC1V5lq
 UAMQ==
X-Gm-Message-State: AOJu0YxlZGpnsakjCZtlWYUdmSNLXnzrBBN1B2HC0N06i2hYXHr7g1x5
 XWU6hcIT8qAWJrgQ3F5CvUE1mYCFjq2u1aaTwSFkPaGi5uC3kMF3WtzM7eFpjD0nSGoT698cAYu
 GqohV
X-Gm-Gg: AZuq6aI1NTXLuQIrNF0Ko4g/YqDh5JLEU0nCbFhlg1xOvk8b4cmPJsAsOEVGP2pkCle
 jCszLvlp+6WndPifDPggAjyMJEJ1fBn6gcB4NZWiv8Iq8Kbm6eDiIipJByNtvczv28zb4Rxxy5x
 laeNbh44utu5qRgJH06PF1ZtRPAft6tjHd4zKJio+p3RnWLlsw9/nB98+917aKfwwrZK7HKXhqa
 NHk/D5zg9Tq83Qxmm0jS3r01096FHNvHjpl8UkS6nyw8znarA5iN4/gqNg79TQh753Zb05r4/J5
 tHGzqkeBFXnQJTqPV/hJwEIVURRDnDGT7HAAS2Oc3AhuzlCTce36iiu28v1QpyoxZyBErU3AZEH
 THUZlw/Olv2g1SzHkV5dQ1xSCdBLUbdnp9r/eWJTI7e8YP8fNCmpyJdwV7qtTaMgTPqVAuoIdcl
 mZYiS9xR69gJf8vx9x003LSQ9SdpOZ8zGj7uJwKu1wsOwvlMbZUKzpT/LejNfkPqz9
X-Received: by 2002:a05:6808:524b:b0:45e:f092:c665 with SMTP id
 5614622812f47-4644635914bmr3848536b6e.44.1771814987818; 
 Sun, 22 Feb 2026 18:49:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1efc76sm4241777b6e.18.2026.02.22.18.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 18:49:47 -0800 (PST)
Date: Sun, 22 Feb 2026 18:49:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: Re: [RFC] test/eal_flags: suppress vdev_netvsc auto-probe
Message-ID: <20260222184944.0b43ea22@phoenix.local>
In-Reply-To: <20260222221542.804546-1-stephen@networkplumber.org>
References: <20260222221542.804546-1-stephen@networkplumber.org>
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

On Sun, 22 Feb 2026 14:15:42 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Hyper-V systems (including Azure-hosted CI), the vdev_netvsc
> driver auto-injects itself during vdev bus scan. This interferes
> with the vdev flag test causing the nodeaction subprocess to fail.
> 
> Suppress by passing net_vdev_netvsc,ignore=1 in the valid vdev
> test cases. The scan callback sees it already in devargs and
> skips injection; the probe honours ignore and does nothing.
> 
> Fixes: 0d684a783088 ("app/test: fix and separate --vdev unit test")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Self NAK

This is not the underlying cause of the test failures.
The issue is likely parallel test invocation overlapping on the file prefix
which is already addressed by another pending patch series.

That said, something should be done about vdev_netvsc driver and github
interactions.
