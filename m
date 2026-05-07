Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F40FCD3442
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 16:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63CE44027C;
	Thu,  7 May 2026 18:57:59 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 6F9004026A
 for <dev@dpdk.org>; Thu,  7 May 2026 18:57:58 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-130c653cce4so3034195c88.1
 for <dev@dpdk.org>; Thu, 07 May 2026 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778173077;
 x=1778777877; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uxh2/8OduHmqV4iSHevV5hrWWnVYUD+34uIYDUbXz1U=;
 b=oiRwA1rHkfvfROUSbJjccU1eJehUca/EUaP8dGOA6hsasqX3DFrYD147U/NQK9ES75
 RaFqciKwIV9GlEOgYzkx3nWxu8xQKlPY7U/2P8nXVrPcI5Grhr4gjgnn4czBBcp70Iyv
 cJenf9nZFf6d0/m6eEZwnGr5OJi+BhqM44fbwvghB0SyEpT/fu0INniwngOXVtO4UDNy
 xBnrjMgHI8qdvk37qMQZgTDB5wLbei3X6nVSvzUYpUByXSpoQKjcUXGsRq/rfYfwfzKB
 CSocicS1XFUsK7+S1r9gZ1isIOUdatdNxegVzLRZqwc/XH/qrz6wQOpCUN6T5Z3p9zxa
 efgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778173077; x=1778777877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uxh2/8OduHmqV4iSHevV5hrWWnVYUD+34uIYDUbXz1U=;
 b=iyFWbvJWq2PpbbqoTQZvi/WEJqk5kUkpmrsXmONlkc0dlTAmZbeFjset75Rt0QOrE/
 DKZh+qPT6Cd1q7+/HrffamCioWdRQXjBXr5KGv1bs+ZifMobizvjA/vN/rmeA7JHabnV
 SHp3w6jxj1dtR8P1rhmexNjxrXNVfpX9SlM/KE+9VrzesJvI+j0VTLKvlt5EOc7/IfOE
 WCoVBH89rgyRa+ApcBsKpGUtMYXMyEsTlG+LC1JhSivn5telZVGdCK6M5lEDpDxtwzkb
 n+YZurzFU+IJtlR4gQhOrw6I9dT8CfegE7In2EDZn5N2DI9WZMt8jpd7o4o02C/AKbdH
 PPUQ==
X-Gm-Message-State: AOJu0YzDjr0JpiSa0YZ3dVL2TGEgmXnz3E8OSNrROq9NgUYyp67k6Gh2
 f67ZUW4N+nNeOZYyrsreD5MqHG+avqJcixewzre6qp1Gi0snu0betJlXtegv8mhiA2Y=
X-Gm-Gg: AeBDieuOi0W7pi9kTvRj6G3wXS8LtQRLSF0x0XAru16G1lG/XR4g0VKtk6NImrRyJkq
 0Fl0X+8I3hJxCcOCajuByA+M5m1Z1s49YkxIrf1oLJbkHkjuH9k1NDsrGo6AWVvB57YTKr/CQQ+
 h6g0SauSJovAkCMbRFWaeeQB9kmFpXdz2kYDyk29Hr6G6w1E/yxaGrNi0MMr4xcxWTwGvFK3GqA
 2QU7ukX+CmRZvgcWOhVLrGN9xN2G9Tl2cgLLIsz17GGG5AUNWpNV5qPpi8MWLbI+pfz3P/pMWhh
 1dwCLYUeceezwtgQjexpEqRtnaW7xsoIatnjYHtoD0VQ7MB6zV75Ql45L1XRef9PUHmeaNj0LGi
 eWx40xIC2gNSYBsWBxvubiny1gj8Wndy3HGhO2BkVz4zSAQ5OAA3IUiRnFodOgB8tXs1WFO9ucl
 f7k1KDGLq0+fMTGBVArR+w3DKSDglky16dohM=
X-Received: by 2002:a05:701b:2210:b0:132:2486:acb with SMTP id
 a92af1059eb24-13224860b9bmr1952591c88.12.1778173077219; 
 Thu, 07 May 2026 09:57:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202fbf850sm10448552c88.14.2026.05.07.09.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:57:56 -0700 (PDT)
Date: Thu, 7 May 2026 09:57:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC v2 0/4] flow_compile: textual flow rule compiler
Message-ID: <20260507095752.372bac9c@phoenix.local>
In-Reply-To: <afy9RC1UUlGlqp2G@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
 <afxJCBfkbui5clep@bricha3-mobl1.ger.corp.intel.com>
 <20260507090923.0f8a620f@phoenix.local>
 <afy9RC1UUlGlqp2G@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 7 May 2026 17:26:44 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Checking with Claude, it seems it's there already:
>=20
> Multi-string (TOKEN_STRING_MULTI) =E2=80=94 reads until cmdline_isendofco=
mmand(), which stops only at \n, \r, \0, or #. This captures the entire rem=
ainder of the line including spaces.
>=20
> >  - AI proposed new syntax:
> >     flow compile <port> "quote rule" =20
>=20
> I tend to prefer explicit pre-field names in the syntax as a general rule
> as it makes it clearer what the numeric values in the command are. So I
> suggest e.g.:
>=20
> "flow_compile port <N> rule: ...."
>=20
> In the absense of quoting, I think having a ":" at the end of rule helps =
to
> separate the testpmd syntax from the rule syntax.

Would be good to have flow_compile as temporary solution and replace the ol=
d parser later.
I can't see huge requirement for quoting with current syntax, good to have =
but no fields seem to require it
