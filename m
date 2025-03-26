Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0DC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 10:10:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F744402DF;
	Wed, 26 Mar 2025 11:10:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3CBCA402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 11:10:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742983805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84E41/Havg9ESEDLYbOjMZe2ACfd88a4Oq94fS2N7mA=;
 b=RBWbrqYq0KzhK5Ua3pDJmfP3A9Cdx7W2xFMGuY13F12mVmkiTj+xzJ1NQkX/1+xr/1Qnn8
 845k83dHL7O4i4jZtp+2PmOvyXiYcAxK1NhuyEBX16vjp/GRHshj+kRvIMQwdazgbDp8VN
 MxUiXFLvqW7DQA6cFnT14SEl9zNhGvU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-fCs24LxJMSG_j_NVFMnUJw-1; Wed, 26 Mar 2025 06:10:04 -0400
X-MC-Unique: fCs24LxJMSG_j_NVFMnUJw-1
X-Mimecast-MFC-AGG-ID: fCs24LxJMSG_j_NVFMnUJw_1742983803
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5498879a3aeso2980557e87.1
 for <dev@dpdk.org>; Wed, 26 Mar 2025 03:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742983802; x=1743588602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84E41/Havg9ESEDLYbOjMZe2ACfd88a4Oq94fS2N7mA=;
 b=j5Np0ehLQEXA13ZnTzWrL4CLbcZMSA1VG33NuVvmC6MeObpZJclzh5u75jrte6My3t
 1XcBnRUpaDipC/Fg/HhKNWX9T8VmB631O0NhCbVO9l9BRbwzq0KAGs2yF4rZG7wVjkqn
 kqp9YZ9K4P7uceIXjDWcg/QLOfmvpz5lL3T37p/oMxqhBIYKIL1Yd9JfNHlXwO830I9W
 QEP4T3QdjFzHu39l19TNbKk3P4DFqZP8Fbm+oiwFRFRjtHjIAufZUZhhqnWWEt0j2fxB
 ckX1TSYlfjgtXUGw6OqoU17C+NcuGrOmRNsKyjc1LX2BwXO/i3IXnQ3PmRw80Z1vhaP3
 akMg==
X-Gm-Message-State: AOJu0YwfN1YmOHOhjrKK37CKXuZzQc7IFnYLOptX+kX6Yj5BTRpRArjW
 QwSNO11ATP4QH8zrWZo0nhgchRTzMWs2ktAGLCilNqyIUmskRTx/OXQ4J7dOFN2iLbf9KNSH+OQ
 CIfhHHp63FoQEfMEnXz3F8/W2qcnK/a258xYtKnMSOSLzjo70NHlnbemSVBt2muQyrk7+oSz1D6
 Dh+GSe1lefc9tjOSk=
X-Gm-Gg: ASbGncsFZF/n8k0tbjOWKBK91KaiZ7ouNFrtRNLokuywMXv9FSHnJXo2RPG93hUm07+
 4kToK6HFVQ0ynuoL802G80dOGdZCAG6mdBAaGSbEeSSZNKd7oitrlCO7UvkWXI3TDJIq9YHnsEm
 Y=
X-Received: by 2002:a05:6512:1589:b0:549:7590:ff24 with SMTP id
 2adb3069b0e04-54ad648589amr6937457e87.22.1742983802448; 
 Wed, 26 Mar 2025 03:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRI+piQluvzrWOJsrITtlmdPG6VdOCZDfbg3qm11R00PH9B3efZRYJjX+M7rQuzHW3jFECGQfRyPJHq6DiNLg=
X-Received: by 2002:a05:6512:1589:b0:549:7590:ff24 with SMTP id
 2adb3069b0e04-54ad648589amr6937454e87.22.1742983802043; Wed, 26 Mar 2025
 03:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250326090003.858426-1-david.marchand@redhat.com>
 <Z-PEn4gSkJyCEbUs@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-PEn4gSkJyCEbUs@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 26 Mar 2025 11:09:50 +0100
X-Gm-Features: AQ5f1Jq6woeQye-FUORGQxibC3B-rl0C_oYLM5TEpx20hmUHK18D5a5LcW75rNc
Message-ID: <CAJFAV8yY10dBOHf-fT3gK39RqDDZJfx8u5BWpsVthEuz3Gr+GA@mail.gmail.com>
Subject: Re: [PATCH] version: 25.07-rc0
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9q3FQDnq_Bxd6MjId3YjLzYfJp3EGCz-XMQPvWUIYE4_1742983803
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

On Wed, Mar 26, 2025 at 10:11=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> > index fba46b920f..0cc4d12b0b 100644
> > --- a/.github/workflows/build.yml
> > +++ b/.github/workflows/build.yml
> > @@ -12,7 +12,7 @@ defaults:
> >  env:
> >    REF_GIT_BRANCH: main
> >    REF_GIT_REPO: https://github.com/DPDK/dpdk
> > -  REF_GIT_TAG: v24.11
> > +  REF_GIT_TAG: v25.03
> >
> Do we not keep comparing against 24.11 for the whole of the 25-ABI cycle?

Comparing the new release against v24.11 would not detect breakage of
symbols introduced for the next ABI, during v25.03.
Like for example the changes in 52633e3a3fa8 ("net: add thread-safe CRC API=
").


--=20
David Marchand

