Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D3C36011
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 15:36:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 016F04028B;
	Fri, 28 Mar 2025 16:36:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7B3BC4026C
 for <dev@dpdk.org>; Fri, 28 Mar 2025 16:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743176207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvQX5gKz0UCIK2bZICtgiOEySGEDOyTA6QWC7If4ZAY=;
 b=YN4h32c3f8XNTZ/oLUGQ4tDrkxp4oZC6JzgE7tKLcE5OGUlZTujg0rXlxtF9ydwsldFrcp
 ZTIrq3Wc6FKN0BxusEL3+TMvSVQLg2mRnpi7YjtOz+dUj4sTx97OUkzQyHm3nyGUV9K69J
 txpNjjWTxH1sC/mamOABzw2VXSYg5u0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-m_3H6zabM5-rqJqEmMVr5w-1; Fri, 28 Mar 2025 11:36:46 -0400
X-MC-Unique: m_3H6zabM5-rqJqEmMVr5w-1
X-Mimecast-MFC-AGG-ID: m_3H6zabM5-rqJqEmMVr5w_1743176205
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5498ec88462so1084331e87.2
 for <dev@dpdk.org>; Fri, 28 Mar 2025 08:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176205; x=1743781005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvQX5gKz0UCIK2bZICtgiOEySGEDOyTA6QWC7If4ZAY=;
 b=c4mWJjN2BUalAS2+VLvwXa+PFHI1o/I4kdPnilIMUfij6xUeSoK0nzW+vEzbyPHzVl
 haAnLipo4KQChli6hcKaS9LuQYhncA9aj+3taM0Rx6vh7tuZhOc5E2f/Yd/pKVIUHdcy
 3zxvq7kyKY4SN4nK5v2TifkZTCw45ZH3YNdFIHKCEF8sT4Z0NzC+LgyYHUmACSbT86K7
 /TzSrIE0+v4K0aAaMrrACIY6EQ2UxVPdm4s54qv9pI+irXC8z26ilPd+h7Hdk+Arvs+c
 nLhCDV8+erzQ93z+vyK9n5lNUDFDdQjouhfrMBrMf91AAo3ACCvIFwOO90++Z7fhnTzd
 p9qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkLqDHx9WcoC/tRTgixzr7ThmTLlE8F+9Isn2tw9nlLME14YP5n5aIwrOK5lnLPLMiapM=@dpdk.org
X-Gm-Message-State: AOJu0Yxp2zJl0LWrCNFXUDrgPX/93jGIp9/heTXlTeQLbte1cQyQ6IHB
 5WvSW4uVStuWo3Xi/Q4aiPrS93mCoCXAnd7ILsxmyfsWiaV8xLvMFMnJj9G24owYtss2QtE1VSo
 PLyFmBdSZWR/kZzIHWP4nJRMykw2nNuBh1mWOorWlOU/i5zj3zjLG6guE9aSQsCnVcf4NO1vIBd
 pzM96KYi34lKLN+ZI=
X-Gm-Gg: ASbGnctmDQXnzLB2SbmULAH41kV7bMg5kKkO+oKSKpbKvrBR0hhwN0WI/xkzeJNk2C0
 ews6kCw3sK8A0WbXHOpabotTsPiKmyD3yPkVGHpXwfs1lOEcxkEXqTBG2vcubMqntFyj27yPU/E
 8=
X-Received: by 2002:a05:6512:3dab:b0:53e:3a7c:c0b5 with SMTP id
 2adb3069b0e04-54b011ce240mr3235166e87.10.1743176204755; 
 Fri, 28 Mar 2025 08:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRYndOH6XPJXCnKhXO5963M29ufGikhK7prpnsTdCY6+Z/Qm3PkcN8aT7az3ysqVzFlnLa1KZ9E3+FwTY3muo=
X-Received: by 2002:a05:6512:3dab:b0:53e:3a7c:c0b5 with SMTP id
 2adb3069b0e04-54b011ce240mr3235157e87.10.1743176204349; Fri, 28 Mar 2025
 08:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
 <Z-bASPF9J8_htYNE@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-bASPF9J8_htYNE@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 28 Mar 2025 16:36:33 +0100
X-Gm-Features: AQ5f1Jqd_hJraVqDL4tlW1-shjsOWnFqJEI_H4iu9A3DWO7aX8Ku_u0bWCaw4w0
Message-ID: <CAJFAV8wvDzh6RqC8Tfr_ywPsehW3++BmgkvTnYi0TeiZ71fUVg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] net/intel: using common functions in idpf driver
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Shaiq Wani <shaiq.wani@intel.com>, dev@dpdk.org, aman.deep.singh@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rfaA9jNlQ7VtCbeiz2hZuPHtjZ3iPYSHbgyKqP9gNtQ_1743176205
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

On Fri, Mar 28, 2025 at 4:30=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Mar 27, 2025 at 09:34:33PM +0530, Shaiq Wani wrote:
> > reworked the drivers to use the common functions
> > and structures from drivers/net/intel/common.
> >
> > Shaiq Wani (4):
> >   net/intel: align Tx queue struct field names
> >   net/intel: use common Tx queue structure
> >   net/intel: use common Tx entry structure
> >   net/idpf: use common Tx free fn in idpf
> >
> Recheck-request: iol-unit-amd64-testing

I also received a strange report on eal_flags_misc_autotest, so it is
probably not an issue with this series.

The test crashes with what smells like a double free for a memzone
object, strange.


--=20
David Marchand

