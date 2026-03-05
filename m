Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B1F33A74
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 14:36:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE8640A7D;
	Thu,  5 Mar 2026 15:36:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 63FD140A73
 for <dev@dpdk.org>; Thu,  5 Mar 2026 15:36:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772721383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/YriOxfLThJPy6VWJH2yhPlACf7jzDbcP0Iy75tpHIE=;
 b=BjRftWcVSY614tvMKZ9Qu3jUMbV4tvDgVrORExzXaBsWtm96dtrKfpdJHV+1+/OGtRncun
 JV9CyziSUw0MJbi7kznSdkqoX8san0h/019DUSjDdFW0CdPs36ktVyT5E5IYvwwEMO09X8
 LcS23sBVQnK0dYIiM8B/FDNI4hPMsYs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-9GP4rPl3N-qRX0YL-sAW7A-1; Thu, 05 Mar 2026 09:36:22 -0500
X-MC-Unique: 9GP4rPl3N-qRX0YL-sAW7A-1
X-Mimecast-MFC-AGG-ID: 9GP4rPl3N-qRX0YL-sAW7A_1772721380
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a12c85d92cso701250e87.3
 for <dev@dpdk.org>; Thu, 05 Mar 2026 06:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772721380; x=1773326180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YriOxfLThJPy6VWJH2yhPlACf7jzDbcP0Iy75tpHIE=;
 b=L0/U3fzHXZbmF/NDUHLIjrsea8wkmsWC/M5fjTI0c/+AN1l+Uj7W8bUa3hQ9jy51eF
 hylkWiBqa3s4bUOvSfrS6iB2ILNe8Sb24LCbX68CGjMDqdaJU40aUsh4YAut0oKMqxaa
 7+x13D8dKo1nxmBUL16eekGq22hqVkDgCkGozGEfUMjS+iClyGoAw7V1C0dbAO0hz3h3
 MFbyCqDHwTdjRQZltqM7VyrxCq7xheqKN4QsHanA+MJT0JPVYoBmO8Q79EPkwjBqb31m
 XQ+5s89UQHznP/l1BBGZUVkd8LXJydizZKADoVOOaq9YhnKoq+aO+B3gqGv6JuMjc7yW
 pOUA==
X-Gm-Message-State: AOJu0YySp+fxBgqqzSxCCjoh1YaFDdL5CVnTuGufeF0LnF3wz3j4v1T3
 Zbk8JLc1zve5ERsrjHp8NKVq/BEiO0PjyJGsqWporhqE3NgSBHIKoT2LJ7uMotyL8zbY9s9Ahs0
 CKxLeUzFTBO55DmE4AQGJeQ8rnVPG8bS3V6WHbmWIa6j1tqGIMnq17KgS0fcwLrtgpkH342pnvT
 8IK0Sh5w5C8JJEq+wbkog=
X-Gm-Gg: ATEYQzxOChNQ7HvefR1vHN1XvC72wzRVApdjVdF8PTZM6xmYfAENzOnDClh5xxe87Pf
 DletZRg3L66UttyzLPItFLXIkgJ9Dm14RYbsn3Qg//qK525DCJyAchluum6Cw2UPpyO3bbndpkQ
 UseR2YKq/I626CxFNH6VCHjkt2in0L1eVmsMx3OSgy6GjsnOxFhINuUo8Bp8iIbp8M2aUQ6OvUl
 VMFlIbcNrG+ETtRXg0DkifOIlG5sWeDS3StRGFGwqZEl6U2+vW5U4VJwJWaoMImd/qIlg==
X-Received: by 2002:a05:6512:15a6:b0:5a1:2c0b:bd7 with SMTP id
 2adb3069b0e04-5a12c2adf88mr914572e87.35.1772721380140; 
 Thu, 05 Mar 2026 06:36:20 -0800 (PST)
X-Received: by 2002:a05:6512:15a6:b0:5a1:2c0b:bd7 with SMTP id
 2adb3069b0e04-5a12c2adf88mr914564e87.35.1772721379599; Thu, 05 Mar 2026
 06:36:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772114309.git.anatoly.burakov@intel.com>
 <23a68460300ca4fd5e0b66c09b1e580b878af0ea.1772114309.git.anatoly.burakov@intel.com>
In-Reply-To: <23a68460300ca4fd5e0b66c09b1e580b878af0ea.1772114309.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 15:36:07 +0100
X-Gm-Features: AaiRm53gwMI3EAKeT9g1CSJfdTyZZMmxFKkamEb-98JqIeewZJHcLm6bPPse4Dg
Message-ID: <CAJFAV8xiY6grZX3euLahfggRp9Cp1jpfVH4pN3sRURaBUhL_JA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: add deprecation notice for vDPA driver API
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nG1K9qRRfiN0xLzrni5ksOIs4T2vnjg9DoUbfnAAirI_1772721380
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 26 Feb 2026 at 15:00, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> Currently, vDPA driver API is partly built around VFIO group API, which
> will be removed in a future release and replaced with a device container
> assignment API. Make this know in deprecation notice.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

