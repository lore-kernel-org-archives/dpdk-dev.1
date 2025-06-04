Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144AEC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17005427C3;
	Wed,  4 Jun 2025 12:41:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B43B54029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749033704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G8igW2G4GQpJnZzZ3yZymnnrLyJYPMJgO+zhIH0IsfQ=;
 b=Jbj/f7ZV6ZTHnFgpz1kmfCmuNyXSOHDpEqWC5mADAxIReGhPc251P50ohMAGmVtfLBmVuy
 bE/gEbNbtRRzgb7Y83Qonkg8iFGoPv4nZfSJISVLnVmHZKw6hxV6TmVSpUOFTLtK0VIRd2
 t0h75cy0Tn7NOV9R6iJLXv2ON0I6wGI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-gd_Na4fGM7yyEJacgymeaA-1; Wed, 04 Jun 2025 06:41:40 -0400
X-MC-Unique: gd_Na4fGM7yyEJacgymeaA-1
X-Mimecast-MFC-AGG-ID: gd_Na4fGM7yyEJacgymeaA_1749033699
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5535121d858so1284138e87.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 03:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749033699; x=1749638499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8igW2G4GQpJnZzZ3yZymnnrLyJYPMJgO+zhIH0IsfQ=;
 b=t2fm76sV4vo3YmIfWdJZjZ4SPi1NafEj2JPotzE0B86j/hE+56nj4fioI1zzti1HaL
 sJl+A4ZkvMAbZ0zUj61FlkM1LoIqIGfY/zEzEYSdfNpr20EsbF5phWUPmCbFra3RBlA3
 HZhBALXm2sKVOtftMN7SjcWhyv8qqUHEWeNpwxRNVIHcGO5XCaTS+Liql4gNVPCZLZxT
 ZrRN3M+e2AayE5gyI54xRvAYaLZLOW9UeivcAUjL0r88+euydRZ9CEIi7xEBNCVfj1XR
 hh2hmGmzD0jTpOVsE1ywqjt00u7CkQaDpl7/TsFclxFvSHqNCePxjzPjCk01MPjJzg7W
 uwMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIctXJFiSQLGGiUPXwwiUiSFcwRVsKbiRD0ebo1SVfClMDM8idm+YtWn2+sJefpjTa67Q=@dpdk.org
X-Gm-Message-State: AOJu0YzdBdczMb3XtNG7ldYAwNWeJN7uoaF0ECie5qmC7ZiUXObY0Zc4
 oXkYMmlZrHCWU4SgM23tyvJmDtfHeFYDRgD/noBZUMWyr0zpAQRuWPb9/QpQ4CjKhJ4tuafKamn
 68TUgZJsk2/6iTCce+2voczqZsSaclqGJ9waHgkWzPZTDK/Zu9yf80VV87V1KJWJfOAY2xhjZV6
 PYQ8/yk5R5PIYF9ta+JXQ=
X-Gm-Gg: ASbGnctyDtbDcWzxYgJOoQbrnbJNguI5dJ/W4LbdsBN2UoBCunHXMKFK8XX6mhG210y
 VMS6/EVGUs9keLizCzgzm/kl78OIta5e99gVq+4g4txuyKnx3YjmlG94GBUP3P6TISmndiKLASn
 JtLfKa5w==
X-Received: by 2002:a05:6512:39cf:b0:553:3492:b708 with SMTP id
 2adb3069b0e04-55356df1e20mr640164e87.49.1749033699316; 
 Wed, 04 Jun 2025 03:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjVGgnKY0us3GCVEuxYkyiMNh4MUyEbApC4ENvZ45NubKFDaEq+5e5qCOG8E0PRyholrM03uKE50sJv0rAw8A=
X-Received: by 2002:a05:6512:39cf:b0:553:3492:b708 with SMTP id
 2adb3069b0e04-55356df1e20mr640158e87.49.1749033698900; Wed, 04 Jun 2025
 03:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z3zqxm_VLXkztjThS3XhuKrJ0kf_yjeSgx+VjXaoyh7w@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCBF@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCBF@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 12:41:26 +0200
X-Gm-Features: AX0GCFvXjws4jIGdNmudHqY7VT4sYGLDFna7fAh4LZpSHQNmAXNOIuBH5_qVGKc
Message-ID: <CAJFAV8wboVDP8fp=CyQwi6nD7bbu11RjBa35un5yr0faAp2i1g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] add portable version of __builtin_add_overflow
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richards@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -IamYM3zR7n50qfDenFrU0FJCLWCPJd9mQA3IsvKNDE_1749033699
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

On Wed, Jun 4, 2025 at 12:29=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
> > I am not a fan of adding such public API, an internal API would be
> > enough.
> > Do you plan to add more helpers for math operations?
> >
> > For the current helper, the only user is a driver (base code).
> > Can't we just wrap a __builtin_add_overflow (under #ifdef msvc) in the
> > osdep.h header?
>
> We already have public APIs for bit operations in rte_bitops.h.
> This math API follows the same principle; and math operations - just like=
 bit operations - might be useful for DPDK applications, so let's keep it p=
ublic.

This comparison is poor.

There are many users of bitops in dpdk, and *public* headers needed it.

Here, we have one single function in a driver implementation.
And this code is unused (__builtin_add_overflow -> check_add_overflow
-> ice_get_pfa_module_tlv -> ice_get_link_default_override ->
ice_cfg_phy_fec, with no intree user).


>
> The only issue I have with these (incl. the bit operations) are that they=
 are in the EAL library, although they have absolutely nothing to do with h=
ardware or O/S abstraction, so they really should be in a "utils" library.
> But that's another story, so let's not burden Andre with that.

Orthogonal to the question.


--=20
David Marchand

