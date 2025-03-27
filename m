Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9413CC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 18:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5AC6406BB;
	Thu, 27 Mar 2025 19:29:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7ECE940654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 19:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743100195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKI/8zaNOdxxRH2u3bfYuidxUSUlRAlaq5FUUVVzOZ8=;
 b=VUtSUnbS5omu7poBuwcaGrnQYCR87WUo+fNvVp+Q1O//obLZdY0Ce3DV0kmueaHwnzh0+M
 MfM1RZ5MXzgVzpXwqbYpE1/UuVAWJi/eIkvfMxXnUCeRR9hfrX3eNsiSI479LngC/ga1+e
 op9eAr47fvvpwlgM4H3EYNg5nxqFl0U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-KM2qg-VhNKSOXMCK78feOQ-1; Thu, 27 Mar 2025 14:22:57 -0400
X-MC-Unique: KM2qg-VhNKSOXMCK78feOQ-1
X-Mimecast-MFC-AGG-ID: KM2qg-VhNKSOXMCK78feOQ_1743099776
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30db1d3b643so6970701fa.1
 for <dev@dpdk.org>; Thu, 27 Mar 2025 11:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743099776; x=1743704576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKI/8zaNOdxxRH2u3bfYuidxUSUlRAlaq5FUUVVzOZ8=;
 b=fhPeFWRniE2GTD2VAv7M+Gp5hCtcFYUUObvf0g2uo/nCvjA08k8x8xSQxA1iE6DGMm
 h1BLzuc8fhjJqhBNj/ANRucOCY1uJrFjQZxBr2qPZMJJMLa7SnoELqLPybbzsSTvxv1P
 rSP0W+Tgmys6aJ6YWVe2fJWStN+oWRsSxuLE0idivCShSUS7V5MS7fWnieMZ6RcXQd4g
 WYI36hPPHCyS7eQczRk2ObPh1aGUupn5hcr7VyYzJd2IF/S9AmX6xsdzKCd9zJeKFa3j
 YbxbYafpDZl+MqvPRHzE7EW2+vpPmWI/8TW/lO/Lv1pKQ1bU992tbItDe9Ne/9N8sj/H
 6iLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9DN7tjIAxrzxF3rtzI6EGx5Wl4u/TcRH/UnI8My/rg5GDvD09ROMvnttL/W3k7lE2fw=@dpdk.org
X-Gm-Message-State: AOJu0Yxrj+dkVdkdvzmeChXiP4VGBNkkDU568+R/Pw1ffegOhabYSi1h
 I2w8Ne+3raacbT2yluOPriTrYUcVDsmGR9LCXD1EzFU22+5erEBNCivdUHAU95txhc2GvBIbf6o
 D3qxyJyqB0CdkL84aemyZr6dekgHP1GvERQrxNnhJfRZlIxOywpQQd+hcn+KsjadYEeYLlCvuPP
 N6Hp7NhR23J85Lzdc=
X-Gm-Gg: ASbGncuXVcl7ErIQEYcak30Y+WZZkyjJr6ISrlylAxKIZlHMLqWXWV1AR81c4wuQrU3
 GuZf/9xWoRxqjRFiDKldKef8LtGszqt7/1jzG/cD28r/g+ibMSGQJRrTqVf8iVBJD4ekc12XxYs
 M=
X-Received: by 2002:a2e:9b17:0:b0:307:e0c3:5293 with SMTP id
 38308e7fff4ca-30dc5f543b3mr16407861fa.36.1743099776087; 
 Thu, 27 Mar 2025 11:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuqJG+5AJTTr8uAqJ9+NMgcyDvtWXlYvZtd8/jLUcTX98QgeXhy+VUAw94etnOjD1kgMehkDzby4kmlaIfYoI=
X-Received: by 2002:a2e:9b17:0:b0:307:e0c3:5293 with SMTP id
 38308e7fff4ca-30dc5f543b3mr16407711fa.36.1743099775680; Thu, 27 Mar 2025
 11:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250327133638.2983276-1-david.marchand@redhat.com>
In-Reply-To: <20250327133638.2983276-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Mar 2025 19:22:44 +0100
X-Gm-Features: AQ5f1Jr59CV1tTwLWcaJjISBHuaRSi4vtMbMLQl8LgMZxStpnXiY8HbWhVWdvsk
Message-ID: <CAJFAV8w=MQpRVRfUF0qDrUYGAwce8WMAsjru6oUS8PweANOS7w@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Symbol versioning and export rework
To: bruce.richardson@intel.com, "Mcnamara, John" <john.mcnamara@intel.com>
Cc: thomas@monjalon.net, andremue@linux.microsoft.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xAZ4F_wJJU72q1aibEpDPEsx0gValVnjL7vTEh7_0v8_1743099776
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

On Thu, Mar 27, 2025 at 2:37=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> So far, each DPDK library (or driver) exposing symbols in an ABI had to
> maintain a version.map and use some macros for symbol versioning,
> specially crafted with the GNU linker in mind.
>
> This series proposes to rework the whole principle, and instead rely on
> marking the symbol exports in the source code itself, then let it to the
> build framework to produce a version script adapted to the linker in use
> (think GNU linker vs MSVC linker).
>
> This greatly simplifies versioning symbols: a developer does not need to
> know anything about version.map, or that a versioned symbol must be
> renamed with _v26, annotated with __vsym, exported in a header etc...
>
> Checking symbol maps becomes unnecessary since generated by the build
> framework.
>
> Updating to a new ABI is just a matter of bumping the value in
> ABI_VERSION.

Intel CI keeps on spewing non sense failures on doc generation, as it
filters out doc/ updates from patches...


--=20
David Marchand

