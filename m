Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCBBC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 09:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A0A840268;
	Mon, 10 Feb 2025 10:36:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0451A40150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739180198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyiFNnAaATN/gQYZoH2CiNTYvfb6/jGaNxr5ta/SX+c=;
 b=f15zo/O4GiYTo/hUsc4H7Lj/+7ZgQCmDfm+9dj4cX78UfmXwSOvrfylgNBUNeZr/TI0N9j
 HKrZ95Usi/GAeSCkOIM2KyD7jnpMoAoc2tGb7yx20rps8/DXX96leAKFHBS5FTUtlpHb0w
 NzoMpgUqBY0EcgaGwFclzkGZKNZCbsc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-bfONyESOOHGXqmZxi6bBsw-1; Mon, 10 Feb 2025 04:36:35 -0500
X-MC-Unique: bfONyESOOHGXqmZxi6bBsw-1
X-Mimecast-MFC-AGG-ID: bfONyESOOHGXqmZxi6bBsw
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-54508fa5d1cso590024e87.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 01:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739180193; x=1739784993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyiFNnAaATN/gQYZoH2CiNTYvfb6/jGaNxr5ta/SX+c=;
 b=aeQ3d/UcYKaZQOTMpYCePE5UjwVVfKMAQ0R16B96ZtsELHomeQC+nBUEn7qk3TkYI2
 /H9bLpITWLbgEKFxggWXQ5GZDXup274hj735SbFI6d7IOIG+8D0MaSO3f+gxLqEcSiIZ
 RAblJgNwaWtSQVbBqlUoxuZ+IP+ThWzrpPTm7CDkfflPH7Lllar8NUdOAOIKLHYJyG8i
 oRGZBC9dxR9L61Xa6GDwEjqWwYxsHmrnvoe6zfs6/ehoZ/ZpXEtJvv0NFIhakR/O+a5Y
 5FKoSw8jgrEDnPn/IB2P7P8GUJpVjuE0F2N3bLYRAs7lbDUf/iKrZknp/bwnMH5LJKTX
 MMHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJZZHMQxvqLgCc+Nz3fn2GeAgp3ITXifZGQyLYPPlQXSROMByQi98hoplqZvfiy07JAjs=@dpdk.org
X-Gm-Message-State: AOJu0YwXkJHjtTIIJWwGU8XiNEA1827sjFepIiTcxJsTVDtmGXr+TAeq
 u3RI098v0vJ5eUqNniLcbYA8Gk9Zu1K3xasjPZXlmWtjorihO2JxTCP2Sp0LBJ6FqEEZa2zUViz
 qQh0TiwrCdPQNCL9ebxOCvRF1WA31zbOK4Fe/oK+MqZC2RmcqzQS9BLzaljjdJVHvc06eM97yC4
 fSBDZH0yV0lVKKGgU=
X-Gm-Gg: ASbGncshXyInDhCOfFvlPCWzsX0j9SE/YhHOrXp9t16aAo83KeULnzO8/USMbt/dKSa
 O0fL9taUmHb7+a/KEwFsmK9yW8EcNuQmvojtiP0myBQSswODMlqHGH+DX/cpzPBMU
X-Received: by 2002:a05:6512:4893:b0:545:353:4d46 with SMTP id
 2adb3069b0e04-54503535125mr1905767e87.25.1739180193564; 
 Mon, 10 Feb 2025 01:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn5eJZ2QDuarweFuN6AeVTKpMBSBCNSG5ZTzsMXxrVnR3lzF7j+XLS8attpyvRbnVGPejb42+1DbugNE+/xVc=
X-Received: by 2002:a05:6512:4893:b0:545:353:4d46 with SMTP id
 2adb3069b0e04-54503535125mr1905761e87.25.1739180193180; Mon, 10 Feb 2025
 01:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250130145849.82003-1-david.marchand@redhat.com>
 <20250130145849.82003-3-david.marchand@redhat.com>
 <CAJFAV8yvVXqnK0mwngjroV-HgtnBpfG50co-3cMgq3AsPLnzgQ@mail.gmail.com>
 <CO6PR18MB386009DC96D52BF64C1FFFE6B4F12@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CO6PR18MB3860F074B0C173655429323BB4F22@CO6PR18MB3860.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB3860F074B0C173655429323BB4F22@CO6PR18MB3860.namprd18.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 10 Feb 2025 10:36:21 +0100
X-Gm-Features: AWEUYZn2pBgMGoSM9eDUEcgPXuIzQnpK9GC-e_18cdEZGrhGy48DUoaN-Jh4CyY
Message-ID: <CAJFAV8zWUjBktVrdtJ2kDmwJ0J_NpwVkYHovjLkdpXnQNT-PnA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in
 register
To: Sunil Kumar Kori <skori@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Andre Muezerie <andremue@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f3RwDCzFsZgAfSWoLX7sEIIqCSZB8pvm-THSQz1--F8_1739180194
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

On Mon, Feb 10, 2025 at 10:02=E2=80=AFAM Sunil Kumar Kori <skori@marvell.co=
m> wrote:
>
> Hi David,
>
> I tried validating series to see the trace results but babeltrace throws =
error while reading metadata file and traces can=E2=80=99t be generated.
>
> Can you please have a look into this ?

Ok, I see what is wrong, in the dma trace update.
Too bad we don't have something in the CI to catch such issue...

Anyway, do you have comments on this last patch of the series?


--=20
David Marchand

