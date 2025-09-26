Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20087CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 09:18:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F93A40664;
	Fri, 26 Sep 2025 11:18:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9C78A4042F
 for <dev@dpdk.org>; Fri, 26 Sep 2025 11:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758878320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FOCE9/QgkUPOllUNJrlU6F1Bdjmq8A3q5TvAzjviARQ=;
 b=HjkH7GbDIBfYv03yQPJwDdg9qSTlo/G5LmKYo6sUseZ8kvu8UOB/pgQjsUeaWRS/qtKVn5
 IBbmXlVpxQT0S3rpz+BjNdQUQCbBep51eBQNNPYltzlI9KuH++qoyf4sDNc1FyMsF0dtmh
 15Np3J11PyK3c5e767LSBfQ1iZiOygE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-w0kg9nt6PQ-fdUdPQlEc4Q-1; Fri, 26 Sep 2025 05:18:38 -0400
X-MC-Unique: w0kg9nt6PQ-fdUdPQlEc4Q-1
X-Mimecast-MFC-AGG-ID: w0kg9nt6PQ-fdUdPQlEc4Q_1758878317
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-578f6ae374fso930974e87.2
 for <dev@dpdk.org>; Fri, 26 Sep 2025 02:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758878317; x=1759483117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOCE9/QgkUPOllUNJrlU6F1Bdjmq8A3q5TvAzjviARQ=;
 b=pyh35X49gsjt3r2N4HaEioF02qJ5q78V0Q+BWIiYfJsK8N8NHrXvEST/gWOhxH1VIg
 Ca9nUxLWu0yjo4s3l1PvpGxnvXLITNVYf+LsUYkGgoHSRH0f9GBhN/HM69pxo1BZWfhx
 GPEkWy+LMRqWiZk0W96tBscIZRlGKV9U9IrIkXMcbYflj9c+0+O2UT7UUAdg48kyNZKP
 vEzFwXiu1IUkGe/4yQsJYShC8Cp5tMvMJUG4KtFlmEywUeYZ86DSwY5h6zCVQvf9PqVX
 9yrXE1zUuQqvC5LvUomiwMPreZ8NOeL3wVZDDJZfri0UoPCIdHZVQ/ZaZqEcESBjN4IH
 55jA==
X-Gm-Message-State: AOJu0YziinWs87RTcE3cmt/9PEya/tH9h6JxBwGoK1ViQr2l+3yPbxJT
 m0k4RvcS4vD5vWRuzoF/Mcx/QT+pNZ92zGmOW0QQRcfw/4nACHJhs5ni9BszrTjR4WVXT80hT5B
 pFg4410Yo2ipiNjWXFEsZwbIwACuCqeBULcztNuVsXaRaZ51Erw8Oe8EAlXATabl8qA8kCX9pYw
 n7Cft8eVaER0CSm5Em2JM=
X-Gm-Gg: ASbGnctNNYEpLcYmpZbqzLdVSBFI27FSARAmLvfAUg5RZqqLIaam71+CHTInOReSBRG
 NsWQ7QjW5kyP3k+YjtZbje3Z3x8inZLOk6x14A3ME1hfEsl45u82FIN+TlamJia64AX7bqA8LVU
 KtdkXW41fwlbCI7wkoYv9aO8M=
X-Received: by 2002:a05:6512:10ca:b0:57e:d7be:c01f with SMTP id
 2adb3069b0e04-582d1fa2368mr2071919e87.14.1758878316823; 
 Fri, 26 Sep 2025 02:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHknznpHe83vz5RKdjxiQg8UYzY3G2s067uJz1lCJnu2C89uf2Qch47FSIpa3pilZBjJFNLw5wZ1pnw/0XfPeQ=
X-Received: by 2002:a05:6512:10ca:b0:57e:d7be:c01f with SMTP id
 2adb3069b0e04-582d1fa2368mr2071911e87.14.1758878316233; Fri, 26 Sep 2025
 02:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
 <20250925123150.3063298-7-david.marchand@redhat.com>
 <aNVV3PwL39sY-W80@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zjD5M7DDapTZfjCzusm-w5ufBJq+0C3wkFeKt5o79rGQ@mail.gmail.com>
 <aNZXeXui-n59iRAb@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNZXeXui-n59iRAb@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 26 Sep 2025 11:18:24 +0200
X-Gm-Features: AS18NWDRKwahr3B7iShA3qr1G9LyvD1ENFLbPDq0DchTm_4zqjndVYi8RYeubzw
Message-ID: <CAJFAV8wiFYR5Ag9PU81bLibn7H0SeKc+fqa0c7j=jSX-KdkduQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] buildtools/chkincs: use a staging directory for
 headers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mhNvFEEKa36YvuF7_0pEap5BTckG2L6sMuqct4qHPZ4_1758878317
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

On Fri, 26 Sept 2025 at 11:06, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > I just pushed an experiment:
> > - single headers install:
> > https://github.com/david-marchand/dpdk/commit/headers_rework~2
> > - chkincs rework (still not using configure_file):
> > https://github.com/david-marchand/dpdk/commit/headers_rework~1
> >
> > WDYT?
> >
>
> Those changes seem good to me.
>
> One final idea/suggestion (apologies for the many suggestions here). Rather
> than having a new script and dependency tracking for the header copies,
> would it be easier to do the header copy as part of the existing C file
> generation script? It's already writing a C file to an output directory,
> would it make sense to have that script just copy the header file to the
> same location too?

We still need something to stage "indirect" headers that are not
preprocessed by this generation script.


-- 
David Marchand

