Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7791CC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6454A402C8;
	Tue,  3 Jun 2025 16:32:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EE6244028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748961159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTmG3ZNuu7JZ8xlaT4Jz0eSNLwfl+i5HVZTqFySTonA=;
 b=DGJu+1mmiPlhpPdLGhi4cwqMrv4E/ltOm7OvLXYAzaJpK2c2qoVK6LVpCjPNcmRWadH3uF
 ondiL8p3nrgpElmC/SGNUjZDr1DBvGZvvwwEmQhUeGBcZrfW9p/N6qKPK6I0Qo3iXv44Mx
 0kFHAz91C/i8WldD8UmvMoh/3zYnXqc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-vx2zY-5PPfSsQ3yRPhmxOQ-1; Tue, 03 Jun 2025 10:32:38 -0400
X-MC-Unique: vx2zY-5PPfSsQ3yRPhmxOQ-1
X-Mimecast-MFC-AGG-ID: vx2zY-5PPfSsQ3yRPhmxOQ_1748961157
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5532f32cbdfso3320333e87.3
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961156; x=1749565956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTmG3ZNuu7JZ8xlaT4Jz0eSNLwfl+i5HVZTqFySTonA=;
 b=WW7B9/p3v80+TLLYymJUMMZ0IyJiPpM0UUgefYloyp9yhiqNaYAKVKWWAYHk54jVm5
 Sthq0XX/4QnNSWAReoZ8iuarmM1Lm1CY+FieDLP8qro0ICWhQImTVz0vEisBjKu5lCqr
 +Bimt/D9y3X+mnotIJNTyjfNcU7t+73jrQApPbDvxe6OWPhEpypMNGHhpKPW/eZYkVw/
 pdQTFuPr6UGtNllSlIBOzPl/oY4Da0dt0I8J50bZyzYwPqlkd9RmKX9F8GHxBcnzmlEO
 ZqBpy2osjjQCjzsjsHDpE7UtItuk6QSGTVslC4mqOmxchneQJLMFo7+j5Nmdorq9TNBi
 8J2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGUK6lR4iRUBliodZdt8nQg0nbuFk/CxX+tt9znYOTo9pyfQcwYC2cYwlRmOFJH25yKc4=@dpdk.org
X-Gm-Message-State: AOJu0YzGFxxduywy5pZ/m1ELOciYCtzgTW+d2WDmas2uY+sRuPY+yyJk
 8rzsOAETHwGopzaVqFNX0O2sEemNxOOG0Xfn0fs91LLGucUlyXTmW8EpZl5UAtuqZ4OeZAKIXAg
 QDoK7lyMIOF7MVabad75hURI/zZkGZSPgmtaHSHM5OLrI6G6cwO1fO4aEbP9p142LwJ3dCHTOJs
 8PB/b0LcnT2FatQYxGPZg=
X-Gm-Gg: ASbGncuuk9fJ33khaWl53gfiQ/Xdns+nM3Qv4CKk1lzOYHt4Mj6tT7YBkEDFa5ze+AJ
 25VJCOJBTFiKF/2RosxNtSWqqYOKTnIYxZvq0jIYh1L1K12J3mtTmZQiO4f/87CBBaIzeZCM=
X-Received: by 2002:a05:6512:220b:b0:553:377a:dac with SMTP id
 2adb3069b0e04-5533b8e1108mr4542539e87.9.1748961156591; 
 Tue, 03 Jun 2025 07:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSJ6tSRQbqzboIva1M2mSaOt+6Ee74advmVTZ/tqTDrjeKGcsx9OtKI4s11/PjukVdEB8FglUXLxe+ENGkjyk=
X-Received: by 2002:a05:6512:220b:b0:553:377a:dac with SMTP id
 2adb3069b0e04-5533b8e1108mr4542532e87.9.1748961156193; Tue, 03 Jun 2025
 07:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <1733278801-19296-1-git-send-email-andremue@linux.microsoft.com>
 <1747417002-28419-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1747417002-28419-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Jun 2025 16:32:24 +0200
X-Gm-Features: AX0GCFvkgUKIW6U-cMJT6z0LcoZtJraGR3zAX6VcezjSFhizzqPgKV4Ppl7T-hc
Message-ID: <CAJFAV8wo6_diSeiupPnJpp15srTKOa2iBLUGNEYrKbzEH7pUqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] enable lpm to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, vladimir.medvedkin@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MUZ1bOKTLxkprin_2cwj2ZPhOPJUH404N8Y46O99_lE_1748961157
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

On Fri, May 16, 2025 at 7:37=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patchset resolves all issues related to lpm that until now prevented
> it from being built using MSVC.
>
> After resolving the issues it enables lpm to be compiled with MSVC.

Series applied, thanks.


--=20
David Marchand

