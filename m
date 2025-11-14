Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED94ECE8D5D
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F3C3402E5;
	Fri, 14 Nov 2025 18:03:49 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id CB20E40288
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:03:47 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-bc274b8ab7dso1587812a12.3
 for <dev@dpdk.org>; Fri, 14 Nov 2025 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763139827;
 x=1763744627; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDp6uOa9luTQ3K6zYoH++FIMjL9u83c+GWcx7tVWll8=;
 b=zyediAitiixhxO3jkNUNSEFiWXKJNH8NL687u7sXFPLLfRTEWKlm34BiWopNdyAivy
 uJKUDpCzzPN/SQtITnj+R5PEoOgIouzN1ZjSOFJz9GSglAayR5DtD13JvR+onqud2n/6
 H27JgKoPrgj5Oe5tql/FX1pvOPFPAp0SfrgTMjHD36jbLLJ+j9IRHBw3I1BJ5doTF8oG
 gN88fSvYlqkEFC+B8mgoiXF6HlGzKsKY7Z9cxVvcqjyYgdQQ4heZHwZivTWoQkeSxn0L
 EOPYd300J++q1cX35Hlz4oOhGu4rzUMtn7Rt2sys9ko5UVX2lYQE6rBCHG5rMvvoNITz
 J5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763139827; x=1763744627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cDp6uOa9luTQ3K6zYoH++FIMjL9u83c+GWcx7tVWll8=;
 b=rdjgZB1zhRmjTcp0xd1FWx6Arb6wouzAKkjXuwFp/lA4nrMlZY0l/YToLiyI7sGAQ8
 DEH6buKwHliQStadc3SwK+sJMw1WL2ZfUeb3RNtzdg7V4KoxdSzQRPptdkm5W80uR+mh
 xu71fsI9/mg0gJhDOF4+sTXDugagUonGqmxumfIuauBh0lEAGBU13MCHw9M6O+Jz6d0Q
 dQot4SVeko8Oqy73N7SeDxzHqkj2cNUiX4XHvbMUEN9UYLETLlRRNEvm3NBvWFIoD3QV
 owohaUzfcT3Yd+aLuFiviq5nLqGfhO9fxG1v8vGYb3JtdJkyww4+eAs2DWwxDeqWVDET
 QrPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsjuD4K377V0mTdiHaB3Vhw0cDDn4QIoYrmASlLmyOqAv3v+zrn7WUmKhx3K8UJUlLNzs=@dpdk.org
X-Gm-Message-State: AOJu0Yw4XtgIcU+eeJLKLUfmU7zMruEn8vNimixDTdxSu38IEz3+fGP0
 BAm2UwoYJ/co6CCB2XXmcViqhXFA1svt9QwszHJ0TN2oKTBHDtkuM/eNPDDkF0uMdZg=
X-Gm-Gg: ASbGncswvs3FsZdcf81lJY9PQ2MYtbZos75s6Vag6sAMlnazsKBhGFVsvGEZCTfsg18
 RCq/H025N0RGPmHFGrCGu+7cUU6Ij/whqxGgzLMylMFKPzBb6f/stj9IGiUKdb01EIwYdD+f9Gh
 atgieMTBac6OG6VkbUPCKJGZaFUx5mwM5ilX0GjqZbeRUjgnz651fi30XmlvSkCtAqr4Fe60npN
 rrZkTDpq3o3YUr7v2d8vhO3mFtL/FtNISkGOBieLufZO7Y9JMbsyzSlvujBxZ1t5r3UOy39R+dO
 VRqUMyOEsMXG1uXi/uwJB/sW5nYgsh1Tfz3yWIhtolBXGIL8lm3zDo6sl7G4I6wgj45c3GC3W3m
 FTB2y1f4KLB8JSRWiNgsRlL0YASh+3+tJhipXWINnUhXU0pNIkmym1URBLkBIjMZ+haGc6ua6mi
 NgOxkcus7GIXf9kV0RKyatpjz0vV434DH5NJ12t5lY6omy
X-Google-Smtp-Source: AGHT+IH7kBL2cnw0KDDM4FSc+x36iweUBcfr72Zl6kk74vSC5yYq6Vz1pEnS2tfRAdkm7qPqWLOutw==
X-Received: by 2002:a05:7300:8283:b0:2a4:3594:72ed with SMTP id
 5a478bee46e88-2a4abb54d64mr1125483eec.28.1763139826774; 
 Fri, 14 Nov 2025 09:03:46 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885cdsm11887379c88.6.2025.11.14.09.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:03:46 -0800 (PST)
Date: Fri, 14 Nov 2025 09:03:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Robin Jarry" <rjarry@redhat.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, "Christophe Fontaine" <cfontain@redhat.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
Message-ID: <20251114090341.589bcbd6@phoenix>
In-Reply-To: <DE8KJK97R8KQ.3SC0EJPIEHSP3@redhat.com>
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251114080532.1e86d13e@phoenix>
 <98CBD80474FA8B44BF855DF32C47DC35F65560@smartserver.smartshare.dk>
 <DE8KJK97R8KQ.3SC0EJPIEHSP3@redhat.com>
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

On Fri, 14 Nov 2025 17:46:42 +0100
"Robin Jarry" <rjarry@redhat.com> wrote:

> Morten Br=C3=B8rup, Nov 14, 2025 at 17:14:
> >> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> >> Reading the kernel source there is also special handling to include
> >> device
> >> id into link local address. This is to handle corner case where
> >> multiple network
> >> cards have same hardware MAC address. =20
> >
> > Multiple physical NICs should never have the same MAC address.
> > Lots of stuff will break if they do.
> > E.g. a network switch will forward packets to the NIC that most recentl=
y sent packets, so its MAC address was learned in the MAC address table in =
the switch.
> >
> > What is the use case justifying this tweak in the kernel? =20
>=20
> Some drivers expose multiple ports sharing the same mac address.
>=20
> This very is specific to certain hardware vendors. The comment here
> refers to a change from 2005. I couldn't find the root commit/email.

Yes, this code is in first git commit 2.6.12 from 2005 it is possible
(but not worth the effort) to find it in earlier repos.
