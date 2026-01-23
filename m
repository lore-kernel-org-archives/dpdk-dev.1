Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88322D77880
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAD364065E;
	Fri, 23 Jan 2026 17:36:48 +0100 (CET)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46]) by mails.dpdk.org (Postfix) with ESMTP id A6FDC40615
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:36:46 +0100 (CET)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-64942ebf1a3so2422309d50.3
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:36:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769186206; cv=none;
 d=google.com; s=arc-20240605;
 b=bZDHXUDK4y96yFs0uM84XHc07FDzAiuc1AtTMYiwaxBJ25OKNDS/HxklprY/ILNMJw
 t2usBvNTfRf90vGbY0fEapnfzosZBr+fal0natmdOfuHYytFF+CdJ8r7Jf+rfufG6Ojc
 kh2376irKWwKRgDTEqwknvD+Icko7jfsiXIsRq8kfnRckWZ8cEv4u6T1BduHGT5bZM7b
 W7UZog3F/+u6v57D8nG5Qj/07AUtveeCseiNGG/ZzMGlFQD8J91Rpo/9EMWkLC/k5cXx
 l6ErymrjJFM5YXqzSpA+Khm2eiVPnt40W0E5lITqOgBTTkSMrGT3V+wKB/w6H3KinX4q
 kdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=em+G4UQblJ/0q3m0v2gNfnIHPtVSwiW44SAH048ZTDg=;
 fh=Ja5zCWKe7sSzC5FxZQZbE93J+nulY7SP5B4cmJm5fE4=;
 b=L/bbARMYEcmwK2G9uuQsrydH/B953LvPgMlYL82sHjVGAUILzBRo/EuavbW+ZqDT1n
 OFJ3yF3MKBtHCmHCHNUQQBh13cqCNls2pvv1cL/JsNwAXca9Ly4wofj/DjpndFZXfWVF
 ZrbEASclbRXXlrCVbWGrz2INfNzc7fc6x84j3qhWCVQ4Vt8w5MmaeGQSVIgmHZ0yOGHR
 CwWiO7ZytHSzdenXJf0yM8m+lPATTIm0FulU+58zp2nOyVrSGvNwuMw4hgpzgPbstl+5
 DIpVwG1B8179wsP+kryVC1wY7vp+ZF1ZYlfxa1/nSxY0vmCrqb9cvA0KelYCV78CRfk8
 Bn7w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769186206; x=1769791006; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=em+G4UQblJ/0q3m0v2gNfnIHPtVSwiW44SAH048ZTDg=;
 b=gqSaLODlgluOEaqQIsvg+TpY5pbzTHDjUkXhmmWi7zWH8CAnbY7Ser6lDVT9uAUJhK
 OZhrDIJsTLEN/R8O8XlGl3ut8D0Geude6i0cKTr7u/uAj5Ofymre4bDZxc24F0mXz+WA
 Rle+GP7AWZJUauZuAtvnvTnADd3xwZzEpJNQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769186206; x=1769791006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=em+G4UQblJ/0q3m0v2gNfnIHPtVSwiW44SAH048ZTDg=;
 b=pVCZigW3RPxU3UzILsiPRaKtY7mcmOCPg13RBgPLwl/5VmuqriuVr/eojBbloYD0Qr
 y8fnwDWwCmUSqgvNr+wOOkPKjUBjnaOuHhLlDTAD+vBVUrobdeAsNyCZS6g6RIneBzyC
 0iW+q1wIIW7TMbS99xIx2iCqnbbuCrvPOh/yPcleTg1NQ82Wg1liPQkLcuX3x+2+bz+g
 c2eEqMsb1At2WfLSrLHn6hhEb+0GP5jai72xIMlIh0T94mc6TPa3VvZTV/mfT8oIjw4G
 1vzE+xOgEQbF2kCqqBgA/3/Wjbwf8IEAFcPVdRSueJsQm1N3g8kJZnp7MOEV6+xfXOlq
 5FmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7usYL3Te3XlPFTe6i4xoKUcANP/Kh8wo+HRKOmDN9lEKbJz9aN8j8nPuaSdnSMr8G9sk=@dpdk.org
X-Gm-Message-State: AOJu0YxnS5MJ8wtHdru4imvHtIOMTsIZ1kT2axCUfgl4aDcwy25KNV/A
 dzNVMhlSN9g5q0DYIYjs6W+RLlJ+sUNihdTFOuPs31ShclgcgJlgB6UeJTUWgOTRR+0I6yLQCtL
 T2ZlpSIcZOehpZltcdSd06xdJlgNKo15JzOC8UulCEa2trXxYKZ/n
X-Gm-Gg: AZuq6aLRARMvWjW5nEIqWrjM9OXySrGDysovZM3xtcu7Roivlif62zz17xSBqYMejtb
 iuB5BBiOjnBfd0sTP/28doiwgTQWJjpeBYWuPy00/jwiMB9qpdgJlCFAJi/SQ+ZgzL9d7KhYc9P
 hkCKujw/CmrG9W4y2OcabY3CKcIiMt2axoar9EP3GiQxsyAmwARBKrqVEAQZZKyHgPe3CpS4NSN
 E72Mf8cXuKEbed0op2M1GUQF95YH9fXC0NaqziGTqCOdT8Sdfr8ZAyxVYha+1Lkm5trGApqE/nr
 IvqxDXnnug==
X-Received: by 2002:a05:690e:249b:b0:649:3897:ba25 with SMTP id
 956f58d0204a3-6495bfe1eb3mr2033260d50.65.1769186205988; Fri, 23 Jan 2026
 08:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260122214424.322422-3-abailey@iol.unh.edu>
In-Reply-To: <20260122214424.322422-3-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 23 Jan 2026 11:36:35 -0500
X-Gm-Features: AZwV_QjdA_luA97imrXdooeXL6XbUWyB9jmg6ZFYSjthlfhNAZrTnjTZs4SA57w
Message-ID: <CABD7UXOmBRWqNvhO5VnyrNmnfiEOE0Mm-Hp-W4HYQrojsbb==w@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] dts: add cryptodev package to DTS
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com
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

On Thu, Jan 22, 2026 at 4:44=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Running the DPDK test crypto performance application is essential for
> testing cryptodev performance in DTS. This application takes numerous
> arguments and can be run in four modes; Throughput, Latency,
> PMD-cyclecount, and Verify. The package to add in this commit allows for
> this application to be run in any of these modes with user supplied
> arguments.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
