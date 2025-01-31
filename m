Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D11C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 10:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE0FD40281;
	Fri, 31 Jan 2025 11:44:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6811C400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 11:44:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738320248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwOoQ/PRZCUwmuhL9fTsHO5IOQSaEyfEy11pBLfHrCQ=;
 b=dIMAw5RjHcFKG/PHmLjYEuBA5eJvvxlJQMyZ87tex9QpKk0hMGWwAzKUfh9V58OE7m2iup
 tVGzcL4w4b4FIQI3m4WhFbOqTauNyVpChQGofTvfRjPtJ42jOqJZ1/w1OEk9W4MOMSSX69
 mZCIvpwOylZgz5PuVNpkhgsw3pRbdcw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-_VE7tCp1MSi0HE5WGxhGdQ-1; Fri, 31 Jan 2025 05:44:07 -0500
X-MC-Unique: _VE7tCp1MSi0HE5WGxhGdQ-1
X-Mimecast-MFC-AGG-ID: _VE7tCp1MSi0HE5WGxhGdQ
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54278fd453cso1077060e87.0
 for <dev@dpdk.org>; Fri, 31 Jan 2025 02:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738320245; x=1738925045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwOoQ/PRZCUwmuhL9fTsHO5IOQSaEyfEy11pBLfHrCQ=;
 b=JLS543h2W/Kjjd22lpCqmKnXsc2BNidrJrUjU9BRFq/3RgJQazUUzq7o/M8v7bN1Jr
 xO4nbyQnxGlrTVMTrT8WCHurcUS9PRKRSjlNR5vWcvBYOMNMeb4iaU7dGyI/Kiy8KGX+
 h6+YFppBo0LGjdUXNg3x6hIpBd20SJS0k92hjQBYrb2ZAtO68PblcmiXs25GABlITSeG
 bzCajIs95uCVnaHJLaE5bLqMWflhrLVqWi89p8zz5PsxkUjdRjK6ODQMbsin2BZCCbDN
 M56hBWCtlysxlvOqDSlWjeCGsJ/shAJ0r56Fw/L/Om1XjhlgnmB4MAbiyqk+eSIJQiS9
 XMMw==
X-Gm-Message-State: AOJu0Yw3+lD/T29V6bnzIk+jpAScIBmdo8HdkShKKS3/isGCVy6KWiOv
 EldXg/1jLddaD1uplkoZJQhOWHlyrPnxXBip31dItDsTeXcJzvyngK3tqBd3bMmC9BXfU5qd2Nv
 +cww0TrNyrDv2iQeGFauzZcyHrgxpOusjsx8kC7QkiDE4wExUKme8SUKa0BYWQxG8fR9+KEa7FK
 FvojDHHTGc7bDTthU=
X-Gm-Gg: ASbGncsaGQ2CloEXh5GuUPRZKq48OPsYG398BSqZz/EodhTsd/6r+M1HWSblXGS9lux
 f5jE7l//JP+xi0ELWP1HK4Q4rWuWaGTqrTkUHq+HPkdisEMoToIOu6xEgC87uUq60
X-Received: by 2002:ac2:4943:0:b0:543:bb21:4255 with SMTP id
 2adb3069b0e04-543e4c417e6mr3189485e87.49.1738320245626; 
 Fri, 31 Jan 2025 02:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF91nyTqjdyOnjCoOxjptKceV8j9E0A0cjMf7ODAAhG2jLWGDncbyZ1hynnc983MNHoQaZ+HAAzAK4QdQx1RVU=
X-Received: by 2002:ac2:4943:0:b0:543:bb21:4255 with SMTP id
 2adb3069b0e04-543e4c417e6mr3189476e87.49.1738320245273; Fri, 31 Jan 2025
 02:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20250130192617.2744705-1-vladimir.medvedkin@intel.com>
In-Reply-To: <20250130192617.2744705-1-vladimir.medvedkin@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Jan 2025 11:43:53 +0100
X-Gm-Features: AWEUYZk1C5Hhu4oIl8Ur-tyEAdeDbxsauk3cGvK-dq7NrAJnkywIJCAt4dGOz1I
Message-ID: <CAJFAV8xckXp6mrLcJ=0nCEtygf=s69wSFYUhA+62zvDozN-rJA@mail.gmail.com>
Subject: Re: [PATCH] net/ice: fix segmentation fault Rx function
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, bruce.richardson@intel.com, 
 andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D0QV_JHSGa2QCi44QzHhZrSsMxBfDZ7navqQhErJF9s_1738320246
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

On Thu, Jan 30, 2025 at 8:26=E2=80=AFPM Vladimir Medvedkin
<vladimir.medvedkin@intel.com> wrote:
>
> Fix a typo in avx512 rx function, where accidentally the _mm_load_si128
> argument was passed by value instead of a pointer.
>
> Fixes: 43fd3624fdfe ("drivers: replace GCC pragma with cast")
>
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Indeed, it looks like a typo.
Sad that the CI did not catch it.

Reviewed-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

