Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BDBE63F15
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:23:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A7A040650;
	Mon, 16 Feb 2026 18:23:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B81D40296
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:23:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771262583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J4v6ENPFHOexY5JqZ7lXqS2RFkp3k2q1nnyW5Imk94E=;
 b=VH8PHgymw9XuhZGMqd4tTz4Ub4qZEmE970XYMFETeTWiJqMfhOQm8U7Dwd6oUQmtZ/YYvb
 NjQmEPh5PL/M3sWW9b7LSz5jZgI+mPrBNaJhRgRNJrcj5Pw4AqNQapUVaBsC8kEAHvZQvk
 0aUtAVFc2Wp74ewGaAwtS6xvPxkeJvU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-ro5lkF7jNK2sHqDXheeN1g-1; Mon, 16 Feb 2026 12:23:02 -0500
X-MC-Unique: ro5lkF7jNK2sHqDXheeN1g-1
X-Mimecast-MFC-AGG-ID: ro5lkF7jNK2sHqDXheeN1g_1771262580
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3870692eb93so15627451fa.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 09:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262580; x=1771867380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4v6ENPFHOexY5JqZ7lXqS2RFkp3k2q1nnyW5Imk94E=;
 b=frKLYXuvqdcv67UxBqrtoSAXa+aO/RCeSknGjboCSou67cCS4GuxK0CmIoSSTuVKGL
 KZiLgcpnsIr33c2PuTHnGb0D1gncuUrEgUnjPFROYawZ7onWLs2E4TkH01d9jW/dk+an
 sExlFUBJf3DhtLHpDB47TynsL0R+Wb4z3eyE+hLjbhO4rjHWa1IJG5G0bzJmQI9TVKzQ
 8eqAk4irSFFrFRoJio0h6plOJeoC9FJcTDn+6yQ50TBl633ixM283DwxP6HgS7i4Fusw
 eDp53puo6tsgLtPzUZEw6u0IXEu30Ie2yy5hlR/jaJLVdbOPu41LKBM6e4wIqGbhp+K3
 /Dog==
X-Gm-Message-State: AOJu0YwN6I+CSXzcAXc3v/0Q7OjKLIBpswj/SA/oq17Kz56VmNt8cfZ1
 gF4O9SY+r5vrSewTzpVZOBIT0FQobiq4y+4qW+YOD0YZiO6g+cpDI3h8dgeFUCRJeMe1rKTHWhT
 PglTb/Z8bD0Nw9xO0/eE8Y/SwIktGxJPnikGFtEByYyy9SGKbQoJDFuL1gowzIEY9+jSV7/63nH
 N4djW3NvIaaf2EzuxFxLE=
X-Gm-Gg: AZuq6aKWpDbMG9oZyKqSR7yuLptg66jmsRfjRyzGk5HJOYctb7PbWXF0svD4lMKYStL
 IZLocssRQk0e46QccbaWXNDXjVQS5nvY0ZRgef+1pHBZQRZyPMRUrMIMfTZLP+ZZAiZocWwGJK+
 lSsDhKoXaft3EEjBJhoZUEBiyY4T05HcFZT/h8/1RMfqCBvdIfgESCVIy/XLRLhjZXSgxf/Ja3n
 PevxVY2oOsLNROhy8FBQ0TPvu4GfDj+QcMXGrE3NpkNBQYku0ebOnnU4oanU/tUNhUwBg==
X-Received: by 2002:a05:6512:3d90:b0:59e:6256:4d9d with SMTP id
 2adb3069b0e04-59f69c3e503mr2957165e87.5.1771262580314; 
 Mon, 16 Feb 2026 09:23:00 -0800 (PST)
X-Received: by 2002:a05:6512:3d90:b0:59e:6256:4d9d with SMTP id
 2adb3069b0e04-59f69c3e503mr2957155e87.5.1771262579803; Mon, 16 Feb 2026
 09:22:59 -0800 (PST)
MIME-Version: 1.0
References: <tencent_B09D0FCCA142E4AE5ABFE584E92DCED8CB0A@qq.com>
 <20260213220127.265020-1-stephen@networkplumber.org>
In-Reply-To: <20260213220127.265020-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 18:22:48 +0100
X-Gm-Features: AaiRm53IwPKzORoc4NhImfobw6EDXiCiZjIrbsc4jJH-_R9JpGfMWIB93xpVFL0
Message-ID: <CAJFAV8w2SEdV1QNshrrN1bEtQhD8KS7ajK+mH9Y4jDRemQp9qw@mail.gmail.com>
Subject: Re: [PATCH v6] eal/linux: fix fbarray name collision in containers
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Congjie Zhou <zcjie0802@qq.com>, stable@dpdk.org, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OcKZoq6UPlU8VKNmsXO6YMw9C_SsXc1pc8loQspmr9o_1771262580
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

On Fri, 13 Feb 2026 at 23:01, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> From: Congjie Zhou <zcjie0802@qq.com>
>
> When multiple secondary processes run in different containers that
> share the same hugetlbfs mount, the fbarray names can collide.
> This happens because containers use separate PID namespaces, so
> different processes in different containers can have the same PID.
>
> Fix by replacing the PID with a timestamp-based value. The TSC
> (timestamp counter) provides sufficient uniqueness since containers
> starting at the same CPU cycle is practically impossible - even 1ms
> of startup time difference means millions of cycles apart at GHz
> frequencies.
>
> Also, reduce the name buffer from PATH_MAX to RTE_FBARRAY_NAME_LEN
> since it is only used for the fbarray name.
>

Afaics, the filename generation comes from:
524e43c2ad9a ("mem: prepare memseg lists for multiprocess sync")

> Fixes: 046aa5c4477b ("mem: add memalloc init stage")

This change ^^ only moved the point in EAL init where the name was generated.


> Cc: stable@dpdk.org
>
> Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Updated comment:
         * Base name: "memseg-1048576k-99-99" ~21 chars
         * Suffix "_<pid>_<16hex>" +24
-        * Total = 44 < RTE_FBARRAY_NAME_LEN 64
+        * Total = ~45 < RTE_FBARRAY_NAME_LEN 64

Applied, thanks.


-- 
David Marchand

