Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9F3FD377A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 17:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ACA04027F;
	Wed, 25 Feb 2026 18:53:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4C343400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 18:53:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772042033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8OvDUkTwcxKyvj6tPKCYtGMRACyeVDrB16CFfLicxw=;
 b=D+DFLSYaWRZTdPFUWAQ81ZhyNpcHNpwxFA81/IgYTR7LvnxUcXEUc7HAo5IhwtlzWQQKgF
 sM8j47oSvogDgtF/s5S0ECm07cc4i/Pkdf03F7XGTc8l+S40d/86bH9h9XgZX6cLgoHO67
 GuM5glcQD8r6uAaRpJtZ3ULPlZ2RHIw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Ple5HTzGM_uVbGefZnu_6w-1; Wed, 25 Feb 2026 12:53:52 -0500
X-MC-Unique: Ple5HTzGM_uVbGefZnu_6w-1
X-Mimecast-MFC-AGG-ID: Ple5HTzGM_uVbGefZnu_6w_1772042031
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a1035ec417so635341e87.2
 for <dev@dpdk.org>; Wed, 25 Feb 2026 09:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772042031; x=1772646831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8OvDUkTwcxKyvj6tPKCYtGMRACyeVDrB16CFfLicxw=;
 b=Ee/MWiktvAX8jiF9/XoofDIdWpbeWVimffbc5Su5dVjVKw9DMbsnIbGMyJ7O+JV+To
 vJqwRxJg+/uRVUSYu2/7X9sXfTPCcnmpYfGNrgDlpdZzMge56/wDps/cvtQKdE2lMpE1
 iLV9Kbg6Bu1xb4XyeV98yIpvcF7RDN/cDqSLZkVfZzr0GQJTP+QohwJhWC7P7pXEG9+Y
 CRts4BzD5S+jfdyeoPjhg95oAjluJFdS+iEy+w2UkHehP6wcX2OW9fR3ZrUosupIl4kf
 oIkHIrOw/E67rV1t8jbBJF/G/M+Bz8nGrU/pWFwLM3YYQjcjETfbI9BbVJ0k/ok01N8x
 4u8g==
X-Gm-Message-State: AOJu0Ywf1nfeUXM+ldJpglEX73LjTJycDXEz7qBEBmGay0i6BnCQk6Gn
 u/AJf/cxub6xq55jk/xfzXkCgg+XnIqHnnhRpt0fr9D+bNsfykzBK9RzMKCtZ69wiVRxrBgRMGe
 ewMSA2w/33WNtLwr0oka1ngJfZG/dT962F+wBkt0jqrMWduq38V2NA1mrkkDFbMrr6hqS2yGB5H
 4zR/ZSnIhAweybrjpAO1E=
X-Gm-Gg: ATEYQzwjRLtUzrbqawhzR9aO6MJyRgYXxEKw7/UHlW4H19vkweMXv+LYxAhZ71H/Yvt
 Sr6PgM5oRjHpn5g5XSH0ekS7CACGJreUOspVrDS8cDEELYiBolP9RM/ETiHKFaLDXkmfFceB67V
 dlpOV+zsj3aG9pq31H9tXlyF9BANqYf60WBK43BF5mSi/NW1e8LkaoNptASA/riNkDQZ2FULIZs
 FUqQ8l8KjZUn3EPNM/Q1fDk6H2sX8oDmVNfCeQBgPC1q56MfJmSZrR+P4A+Pmh+yFY37Q==
X-Received: by 2002:a05:6512:2215:b0:59f:6e67:38e5 with SMTP id
 2adb3069b0e04-5a1061982admr392944e87.37.1772042030654; 
 Wed, 25 Feb 2026 09:53:50 -0800 (PST)
X-Received: by 2002:a05:6512:2215:b0:59f:6e67:38e5 with SMTP id
 2adb3069b0e04-5a1061982admr392935e87.37.1772042030220; Wed, 25 Feb 2026
 09:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260225112922.3982104-2-david.marchand@redhat.com>
 <aZ7mabhJYLYiWJOu@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aZ7mabhJYLYiWJOu@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 25 Feb 2026 18:53:38 +0100
X-Gm-Features: AaiRm50XtC5whYskMBRZEwOpTGbhB8UUHsAsgZi5eq0owWfLnebBFCmRIZhhBgM
Message-ID: <CAJFAV8wqHWH7dO+c7v=hvUvRwGrvg3GcykKAu2tCTmYRNdU5Dw@mail.gmail.com>
Subject: Re: [RFC 2/2] eal: configure initial device probing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MmJNu3Zl0CcGbnWOJyaCLml709zfaLwJSLAyG3i3JIw_1772042031
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

On Wed, 25 Feb 2026 at 13:09, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Feb 25, 2026 at 12:29:21PM +0100, David Marchand wrote:
> > Some applications use port hotplug as their primary way for using DPDK
> > resources.
> > Having a systematic device probing is a problem when not all available
> > resources will be used by the application, as such applications won't set
> > an explicit allow list at startup.
> >
> > This is the case for OVS on systems with multiple mlx5 devices:
> > one device can be used by the kernel while the other(s) are used by DPDK.
> > In such a setup, the kernel used device may get reconfigured in
> > unexpected ways and trigger issues like the one described by Kevin
> > not so long ago in bugzilla 1873.
> >
> > Add an EAL option to disable device probing, allowing to select per bus.
> >
> > Note: the current implementation does not take combinations of the new
> > option with -a/-b.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> Wondering about this problem and fix options. Rather than a new flag for
> no-probe, would an alternative flag to switch the default mode from
> block-listing to allow-listing work?
>
> Right now, by default, EAL probes all buses and tries to take all
> non-blocklisted devices. We could add a flag to switch that so that we
> allow-list by default, which I think should have the same effect as this if
> no -a flags are passed. We already have support for managing -a and -b flag
> interactions, which should make interacting with the new flag easier.

I like the idea. The devil is in the details though and I'll have to
look carefully at all bus probe() functions.
I'll try to implement as a RFC v2.


-- 
David Marchand

