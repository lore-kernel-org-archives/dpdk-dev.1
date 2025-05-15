Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39718C54756
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 06:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CF1240A87;
	Thu, 15 May 2025 08:58:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E63D402B3
 for <dev@dpdk.org>; Thu, 15 May 2025 08:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747292301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/COw5WCnYXqfcFoK55u2cWvHr16QR4nRTsmSIn7qyo=;
 b=gmILPjq3D2Q/snSYUrw0glW+XxaCKhecCADarTbXQ0rR2Mt0gyJD/JgRj8lHrC8+GmZa4U
 AKcy6UqKXlBXfPT1awLbn1aczOZlP6zi9bOrLdAo49UpXCiyFCbOWIUjV4WwLDzEPMFAH6
 VgUZ790vDpFMDCjXNtROC1J8UEkMKiY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-t_E_AKxaOhmDStYO5VO_Xg-1; Thu, 15 May 2025 02:58:20 -0400
X-MC-Unique: t_E_AKxaOhmDStYO5VO_Xg-1
X-Mimecast-MFC-AGG-ID: t_E_AKxaOhmDStYO5VO_Xg_1747292299
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54fcb06a3feso251013e87.3
 for <dev@dpdk.org>; Wed, 14 May 2025 23:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747292298; x=1747897098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/COw5WCnYXqfcFoK55u2cWvHr16QR4nRTsmSIn7qyo=;
 b=jPzLZAw86YZxpVdr/Qg7eM/Uzr4jsBxrfB2hlfnBC1jhLvSUwWMisdeHRIlU9qTGoV
 iszx0wdVswJEkOn4kT6k3VDKV9SgHYSWXxgj9XC4W7ZST6alJhBzDrDgLvOOvOkL0fBd
 gk79+5o9NMLu7VySm+artqvXRA5a+BD9eQ/fK3mvVA1/1G/YdKqVlqtfbb/nxGK5UiX3
 BQUdmKEJdUnOBme4b3Ydmb+36JaHI0lQxloOG/QQVnZFtN9R5I0ljeIdtIADOhGLb+0b
 XqMDEeK70NtFIsvK7Z0uM5NM2t0kDXzq47gJ4jG938rxtQfI5XHejdfugx2M1+lZZj7k
 6/VA==
X-Gm-Message-State: AOJu0YyPn36iHlj8efla13Ab61jlNc+spvdCagDVzr5MDobDhGLEDph4
 gPAoe3o8Gjw4fnkC/cqpgfVUMfNaJ6H1tfGbnXrdMGFZE6NssbJRs1uGcf8op6UydDm5+DOkfwk
 tRyz0dAqVRVQihm9JltK0efopDLySNH4JrqwlPFwKUAp7vt2BnqJlvYBEisTfrz4UIwV2890gUe
 /R78YSTjRBwOgr5WY=
X-Gm-Gg: ASbGncuvxvR0NLIwdW3nwFiqTVdyeIRoKU1uC6+PROaQCzhzC852wuEUaOmdEsGg5pB
 rD+exNta+4VxGeerw3eb2TDkm8II4sh0fhIBNFV3+NFr2mb310BkOPMXCpGbdrCKin7hPGns=
X-Received: by 2002:a05:6512:6702:b0:545:6a2:e58 with SMTP id
 2adb3069b0e04-550d5fc875emr2177479e87.32.1747292298529; 
 Wed, 14 May 2025 23:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpbCOlDkbkEwAkVMb4f/c0cUTwbdXvAKVPYGUX+KXXvA2iDbvfcQIVD1KH8NNkrD/ZHQjZlO5bHbe3zhxP3Bs=
X-Received: by 2002:a05:6512:6702:b0:545:6a2:e58 with SMTP id
 2adb3069b0e04-550d5fc875emr2177471e87.32.1747292298118; Wed, 14 May 2025
 23:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250514100306.11717-1-bruce.richardson@intel.com>
In-Reply-To: <20250514100306.11717-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 May 2025 08:58:05 +0200
X-Gm-Features: AX0GCFsF6HNTreEtSeeLbslWtaV6G26bPF2dO2AGn2zqsg4OOo3EDuQhG_4JZvQ
Message-ID: <CAJFAV8zdQe_3fdfaJXxeqfdPkji_ngLWS8W4+8o0ZGyTNkEAbA@mail.gmail.com>
Subject: Re: [PATCH] examples: remove check for old broken pkg-config
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BNa0FRjpHOZFIC86WWF2Yn-3JnY2mn4OuXMCGSUPJ5M_1747292299
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

On Wed, May 14, 2025 at 12:03=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The version of pkg-config shipped with RHEL 7 had issues reporting the
> linker flags for DPDK, meaning we couldn't build the examples statically
> using it. However, as RHEL 7 is no longer supported by future DPDK
> releases, we can drop the check for this condition from all the
> Makefiles. More recent pkg-config versions don't have this issue.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>

Applied, thanks Bruce.


--=20
David Marchand

