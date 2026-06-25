Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1FFCDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44DE440430;
	Thu, 25 Jun 2026 16:45:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 52CCE402B0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782398753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4W11WVFlgeezGMG6iBPAhb05k94cluXIkIvDaQpoyk=;
 b=OYmblevM6pcBQDTNZ4XPlLuFPp2PafMO2OjWHRuqEy+eQfm/e0xpNGOS/7iunEUtixI6O4
 T9BiGEDSJig74vA0zVPJRP5zaWjqX8TlxGf8ibVfl7v+1aw69Lms0kUozGimWWFlDk8/dK
 pS9iRk5QFJiIODVHcYPOqFgM1hwaRy0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-voN1rA6ROdWZtMBkrmff4Q-1; Thu, 25 Jun 2026 10:45:52 -0400
X-MC-Unique: voN1rA6ROdWZtMBkrmff4Q-1
X-Mimecast-MFC-AGG-ID: voN1rA6ROdWZtMBkrmff4Q_1782398750
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa932535b9so802855e87.2
 for <dev@dpdk.org>; Thu, 25 Jun 2026 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398749; x=1783003549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4W11WVFlgeezGMG6iBPAhb05k94cluXIkIvDaQpoyk=;
 b=The3ZLTcLByfwvPz5NDUwWq3L6yT5oZNi9n/LMYL+H5VAZNYpJK2mc5FgTvszyu73L
 WYUQPRhtX/ymHmM5YTRuTMJk+7V0YGpqs+9FXGRKkmsLmjhn01bHY4RSC+K6m8Imtf87
 DHrgd/W5lP0mw4yXJd5wBTcM/r5jAQZUhvq08epGvXMy5lm8v3ms8Srfri7ffdiICaXQ
 HJJr8a1rQ5Tg/KvIDC/wFtfeLS9TpZFDoA1AS3zU8sTdha+QjH9hXf55phcb6qTMP3Wj
 81J7GS+Om1UktNdEZtdwykGs6F7SoZld26yzi3nGVC4AaJox2/M1WOrH394t16M7/qhj
 4vGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaitqQmAYbWea4qKuJEJgaYInPrJRSVdQwABluT1VtZBG6yN1mcs3lphhQZ0aLLpGVkjo=@dpdk.org
X-Gm-Message-State: AOJu0YwgEYdgRFF1AAucroqGS1rfct7iaXhrxbswbqKooCw/apTt9hXt
 bcYvcQzAtZ7OldKLrasL6DxfkghX6oiQZAXqVpCB5JrAyI4fXz8kT9Zj49+WqUof0jeYJLLoDuK
 aYZytJ9lJWgZIyTWfIkU1AMVdJV0O7ZAJhltou19yAp8hgnAZEdybsGtTqrj0bMXlsl0ZywLm55
 XEKJzGeTnFJpZ9/cht/Pg=
X-Gm-Gg: AfdE7claB/SpnHAWTMWlZH4wItCgOjwbT6g/fSPJBPkbQCn94Jj0Km+U0Vwdlnj1SmG
 3V8wYrO68CfUv8gl+tkxhMSz7REcQ0pWWMi92sCrRZcoMb0CffdUG9vuC3FeV/HNTP9961Mm4Lv
 dhe7kUcAFWqB5RCqvX5H0D3KYC7GH2CaBSEZuXzfSbPJILwcwq9PrYlPuzouus++WYE0j/wLqwl
 T0/8P5JtnNl38S6o2Pjn8tq2aj40qQpHPE45fqX5jJ9FVtwLj3JQpn6t3Q=
X-Received: by 2002:a05:6512:2614:b0:5ad:4adf:dd2a with SMTP id
 2adb3069b0e04-5aea1f31586mr912626e87.23.1782398749430; 
 Thu, 25 Jun 2026 07:45:49 -0700 (PDT)
X-Received: by 2002:a05:6512:2614:b0:5ad:4adf:dd2a with SMTP id
 2adb3069b0e04-5aea1f31586mr912612e87.23.1782398748846; Thu, 25 Jun 2026
 07:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625133311.1299705-3-dsosnowski@nvidia.com>
In-Reply-To: <20260625133311.1299705-3-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 16:45:33 +0200
X-Gm-Features: AVVi8CfN8cRwsmzIePGcaikhGOqrfolaTOQlhYgIcVwOw-2OBxlF9KH731CFxWg
Message-ID: <CAJFAV8xG+jGPqzEfHOK3vNcezvsQ53sjq3myr1QoMRmE5wNsCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] build: support function versioning for drivers
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, 
 Yu Jiang <yux.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yauE6MN20nisIZYWyxlFGIZtY3DUIn1xZsQz_9Avi1M_1782398750
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

On Thu, 25 Jun 2026 at 15:34, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Add support for enabling function versioning
> (through use_function_versioning meson variable) for drivers,
> similar to libraries.
>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/meson.build | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 4d95604ecd..8f3ab490ee 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -171,6 +171,7 @@ foreach subpath:subdirs
>          pkgconfig_extra_libs = []
>          testpmd_sources = []
>          require_iova_in_mbuf = true
> +        use_function_versioning = false
>          # for handling base code files which may need extra cflags
>          base_sources = []
>          base_cflags = []
> @@ -273,6 +274,13 @@ foreach subpath:subdirs
>          endif
>          dpdk_conf.set(lib_name.to_upper(), 1)
>
> +        if developer_mode and is_windows and use_function_versioning
> +            message('@0@: Function versioning is not supported by Windows.'.format(name))
> +        endif
> +        if use_function_versioning
> +            cflags += '-DRTE_USE_FUNCTION_VERSIONING'
> +        endif
> +
>          dpdk_extra_ldflags += pkgconfig_extra_libs
>
>          dpdk_headers += headers
> @@ -363,7 +371,18 @@ foreach subpath:subdirs
>                      depends: [version_map])
>          endif
>
> -        shared_lib = shared_library(lib_name, sources_pmd_info,
> +        if not use_function_versioning or is_windows
> +            # Use pre-built objects and pmdinfo sources to build shared library.
> +            shared_sources = sources_pmd_info
> +        else
> +            # For compat we need to rebuild with RTE_BUILD_SHARED_LIB defined.
> +            # Use original sources and pmdinfo sources.
> +            cflags += '-DRTE_BUILD_SHARED_LIB'
> +            shared_sources = sources + sources_pmd_info
> +            objs = []
> +        endif
> +
> +        shared_lib = shared_library(lib_name, shared_sources,
>                  objects: objs,
>                  include_directories: includes,
>                  dependencies: shared_deps,

Older meson version don't like this form:

drivers/meson.build:381:12: ERROR: Invalid use of addition: can only
concatenate list (not "CustomTargetHolder") to list

It seems to work with something like:

diff --git a/drivers/meson.build b/drivers/meson.build
index 8f3ab490ee..79c215a7c8 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -373,12 +373,12 @@ foreach subpath:subdirs

         if not use_function_versioning or is_windows
             # Use pre-built objects and pmdinfo sources to build
shared library.
-            shared_sources = sources_pmd_info
+            shared_sources = [sources_pmd_info]
         else
             # For compat we need to rebuild with RTE_BUILD_SHARED_LIB defined.
             # Use original sources and pmdinfo sources.
             cflags += '-DRTE_BUILD_SHARED_LIB'
-            shared_sources = sources + sources_pmd_info
+            shared_sources = sources + [sources_pmd_info]
             objs = []
         endif



-- 
David Marchand

