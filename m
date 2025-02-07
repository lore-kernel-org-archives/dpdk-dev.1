Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89003C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A82942E78;
	Fri,  7 Feb 2025 15:40:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 679A8410E3
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2qeg2WUMUbzl2yAihIgOfj3PYfLEQGrS70hKJm5e8w=;
 b=HyDNxCqoMduDnaqc8iTR7y5K/pxovk+PsLbLhG9Oj7cNXxItZiwRGJrMnHqmvybJU664xf
 QUM71EvqQuwB+dJHrJLGstEfFpUKbxtgV7CtHAJOIGjl86LALOUpJRN/4l51Y3kwsu920G
 TYuxRlREn7D8kwTzv6sC5PJdlL/eZFY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-4Ejh-tp7Om-fhT0aV564JQ-1; Fri, 07 Feb 2025 09:40:31 -0500
X-MC-Unique: 4Ejh-tp7Om-fhT0aV564JQ-1
X-Mimecast-MFC-AGG-ID: 4Ejh-tp7Om-fhT0aV564JQ
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-544fe4c948cso294539e87.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 06:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939230; x=1739544030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2qeg2WUMUbzl2yAihIgOfj3PYfLEQGrS70hKJm5e8w=;
 b=Tne6WC02tXrXVfxlKBDarddqCxJs9bhU1aIBGHNaNtbZwD22r7AHqw1La1ul/yucO7
 C3HxOcH0w4ngtdcK9dxyqM0BRpThyQdwSmIxvFPo1j9eXRasTwn59+ndig0z93g2jrXe
 hOS0qFLEWPB4GBSXBlvYMGOmW08ABPvu5cyFSzJDf1JUSS2bbIiQU7Qa6E+9DpgRKAAT
 5V3aSXl89dpRq56Pe0robeMkZwWPYMTvoAPq7FJMsuOA0h9uLKf9EBFOMAom//vxJ6OS
 ls+nOJXT8xjQ2A+IxZoAZFmCHmK5NqxvH+Tt+o74ewJnf2n1F7R55622jaIBdRYbmDlp
 babg==
X-Gm-Message-State: AOJu0YzPVlSQAZpRBhwIbvasggHCKISMwowWqzgNxHi03GIGhft92Mbh
 0zyOZcWj7XFLRJoy2OjBjmfm6L5m9XLjvoxq1+3vyDcrYXUJGxCnMZJWSKi4nWyO2uHJ2SYq1eF
 qBTGvD0NVnkj0Om1FrMo5Q1YXpNeIMOarDIWD6fagbMMotPW6rFhO5G42jW/7AFRD1fEAaG0qR9
 m19/rRD9oDy1LcJ07l6flR2QM=
X-Gm-Gg: ASbGncutQrbOX3HhxXJXQxW7JWuskwhIQo2cFSVVStYduoCo+JMbB0cc0CYqTiHy6qY
 i7GqMTz9Iya6JhEMlkD3/EfM4339ZEjix7XZQVEvvbB95TLTa3AQ/rbZyXu845RIo
X-Received: by 2002:a05:6512:754:b0:542:213f:78fd with SMTP id
 2adb3069b0e04-54414af572cmr639679e87.40.1738939230308; 
 Fri, 07 Feb 2025 06:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEm2O8uQoCrU+ti2lUV8v5Ppxixz3HBBSg/mubzvlx8H17As1Ka3CDg8JLpWwaGv0NAGk2KrcR/axYUobe/Ew=
X-Received: by 2002:a05:6512:754:b0:542:213f:78fd with SMTP id
 2adb3069b0e04-54414af572cmr639671e87.40.1738939229879; Fri, 07 Feb 2025
 06:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20250205161518.143865-1-stephen@networkplumber.org>
In-Reply-To: <20250205161518.143865-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 15:40:17 +0100
X-Gm-Features: AWEUYZm2iqIsaX8aVzCdYydhQFXk73yDr2akc_j8g1rVO3WpqgTEdczR8PopVxw
Message-ID: <CAJFAV8xFN==8TmTMW0mRL3Nc7HmQ0HyCU1VAiBrtnKH=j3YbHg@mail.gmail.com>
Subject: Re: [PATCH] log: avoid call close with negative value
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zi_-LMz-3wm54e8-NspBVxBIUN3-b5frBhHy7cwUcc0_1738939230
X-Mimecast-Originator: redhat.com
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

On Wed, Feb 5, 2025 at 5:15=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On error path, the journal socket code would call close
> with -1 which caused Coverity warning.
>
> Coverity issue: 448872
> Fixes: 9da0dc6c0331 ("log: support systemd journal")
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


--=20
David Marchand

