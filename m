Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA7BCA5FD1
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 18:18:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1456D40E0C;
	Tue, 20 Jan 2026 19:18:33 +0100 (CET)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 0F0034026C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 19:18:31 +0100 (CET)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7939e7b648aso57287647b3.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 10:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933110; cv=none;
 d=google.com; s=arc-20240605;
 b=A36imbo3zt7qDG65zYd+JzdbqTJ3RituBfj3lrtBbOsg7m8wfn8a6xIDrLTfomME48
 K1gww4g1PJPstjlxdFWXM4JAt+iBfxv4gfwNoXUMqmspwEjJ5/2TuoitOToGOSJH8l7Q
 SxAIOhBneSKHZaluOFb7wg0Dt6MbFaqLq19uURvHDiWkN/SiLbJaHvpFeDcFYqEtLU+V
 YXiSuVDvHGuTEsLHrxkIrQD4IXn5gVL1QgJ4rjCMyGDXtzLF2xPYLwe8rFnhxdUJobC4
 ttcWzdiqgTpg5+abdJji4kLbmTZUSN1w1HehudrTipW8+IMGOqF8HuhTrwguK6g4bcpg
 Nhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Woa1xO1cWp2rOkx6rEhxCPbCRIi6eXedTvOd1mhPqTc=;
 fh=dc105tMEPT/m03kOhYKqn42nmWUmnauG9WOJMVhbwMo=;
 b=HnQ1tbBdsPNvdn/vjP+WX4Cp3R5VapRFQucy6m2mV9nfmNUqrCgLxz0fxRkCn/ecfN
 1yhNrOQFNFJUWqTObWdJJuF981x68CJG8dT17T+K8d+XapaJv6K0ElOZDCudW1Jcthq2
 S4U5Mk0nFGGgeQGDZbfSKOf+1/BBhEosFdk78vZqMRMGbi6l3W4P+470wS6tLkeJmCs6
 weIDDncn3gz3aWN9seD7mt/n4JJQrgc0STHZOqKXyl3Xeqb4ek7rjlHYcD6zSk1CJXUR
 boCJ5ZZbcvYzedOLwlA02o2qjW8ACn0gqeck0TdjLmZTFzo3D7ogTL6o0E4ZBD7sgJDK
 jNaQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768933110; x=1769537910; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Woa1xO1cWp2rOkx6rEhxCPbCRIi6eXedTvOd1mhPqTc=;
 b=g5bB6UE9aukOxGMtnhi31rrAZeq3IekiJvgc1qLH1JVwZB/gWfoUulS4Wq8X5aVgvy
 mkxpp5gnLnK2BN7h2YSK0/jUoiyJVXeXNNHv0NdlvPGrciNOEY3sS0gzEF3oGr7B9FLi
 MKo7QMJeox9+8JRk+3wcTr7ji5IRLtgR8ZLCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768933110; x=1769537910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Woa1xO1cWp2rOkx6rEhxCPbCRIi6eXedTvOd1mhPqTc=;
 b=E+qxrEiTJMdUlt63nKcKtxIH9GwFBj/j8hXWoIoN9FDUtMGV7CEovkcJMiiz2xNRp+
 JBj1+M5KpiGRRgEbWePoff293c2WeQVQp++9SK0N4YbVUjhn9Fg4kkvi/52tBhgMMdoh
 gg+fRN7cshOZ92Qe9km7n2jXWGsCeqzSc+9hzflMDUc4GIId/RKrIMyFoxuTg9leyhoR
 hBvGWpikVnYHYkX1xNasikOUOBSHMbgrqISLhz/v6zqlHmxtOzY8WbT4NrpWjAarKccs
 7gJQOFC/M1ZPASyaXgehqxjd0Gr/rN5CAtPlgHZ9B4tiyhnjIiRN/W969hIVVDDYOpIw
 MKQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbSgHCg/Q0LPEWXhUZEOLFxnozWKbF4x1JalJTe9aDxgXSXZw3ID3GT/E+9JcYoRJqSZg=@dpdk.org
X-Gm-Message-State: AOJu0YwKs16lGTUrxw3JxCUJUEy9uS95LRJl7QPt7XMl3qslSLO8cUfQ
 DHr58obLAEPO5bsA9L5B99G91z0LybLk7G7371hWAXE8SrEQW6S2DGLhHzAWQ7Iw4Cne/i0FFh8
 xIRWt6xTOQ+BgskS/aYNnmDbuysb3Gfxfp0I60Irvbw==
X-Gm-Gg: AZuq6aKvZtvj6aM50gxAj89VYNXfitXZD5f9xkW7i49p7jvRwPcxbywlZbgwG5s1IFr
 mdnAGdcy+HCQUbJ4dFz1Rs63FtIaQURoiS23rFbbR4Cf0UYhkABymAVgI7wcLm/ioIQfLKbD9JJ
 DdeBV3vYAGawTx0u6h93rfavkPFa7eBcFs/Ip/Bod2XbgNJni+g6nPh4tqubFaJA5lsTf9FqJlJ
 wft6U7xUnFkqnxLUw15EFS88vFGKf0EjVvHz+cja8clAvPHVKG2PHBAWhkVnKwYxUZhmIkymjnk
 YcoQ/XzMOt1YLmchW35T
X-Received: by 2002:a05:690c:e3c9:b0:793:cdc4:8686 with SMTP id
 00721157ae682-793cdc48701mr115382627b3.13.1768933110369; Tue, 20 Jan 2026
 10:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20251217182540.715464-1-abailey@iol.unh.edu>
 <20251218150718.738116-1-abailey@iol.unh.edu>
In-Reply-To: <20251218150718.738116-1-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 20 Jan 2026 13:18:19 -0500
X-Gm-Features: AZwV_QhD_22bP2lBCcyyCAfusCDCER1A2AvSSA38C7wHjO-7fjTCh4jDuYxieDY
Message-ID: <CABD7UXMU7ORQJUae2ABKjDxQAC55J4Ate=4-fGu5BO2nn=cMPA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update testsuite named to be clear and consistent
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Dec 18, 2025 at 10:07=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu=
> wrote:
>
> Some test suites were prefixed with PMD which is not meaningful.
> Other test suites used different naming schemes and this patch updates
> this. For example, some abbreviated words that others had not. These
> word are no longer abbreviated.
>
> Bugzilla ID: 1826
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
