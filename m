Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A65CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 22:53:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88A9C40264;
	Sat, 30 May 2026 00:53:00 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 2751340264
 for <dev@dpdk.org>; Sat, 30 May 2026 00:52:59 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304df7ff4c2so1288494eec.0
 for <dev@dpdk.org>; Fri, 29 May 2026 15:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780095178;
 x=1780699978; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6/Y1wklakfSuqb+07InEHukVVV191HQNzrNkXilej4=;
 b=ZWIKu6LO2D3FY8ACcQog9Ky5E9+D0H/NtcxuXWYrNmlI5hj+BXyR+Uk9+30LNGKM57
 WSfm7fTk9dHaLolECCKY8NvSgwVAveqIpEw4SKwfcVNMrP7JmbrkL7C+4u1KwJXxymGT
 x8R5b1mtciPzUeXJcrFINFYLCb2N30QNX2WECROu0RBPBqfAeomj3AFsLub6fyb0Kp6w
 Lf1U+oyzrF1GCFhkMXPGqWXOXeHf1ssxhplklzbMEMpx16xTOYXieZW4uprV2GM56wnD
 nBhJODXCSDz/EXWSbwTV5S2oDJvkS9lfJH92zrpRflVRfExskG47xvCRMxLWRqNP0JFo
 Lz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780095178; x=1780699978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G6/Y1wklakfSuqb+07InEHukVVV191HQNzrNkXilej4=;
 b=c1yuksatlCo+tIq9D5poYSa0hjLOAE8oDC8VtlImu563HFSaW1/xfLdLkYjIWUGXJw
 2GQ9y8pUtD6tcOz6ECFAUGl4HmcWp6fonU9sCB/IT+QeA+xIcrOY57PQx9lkW3vw+lJX
 R4L9BoR1FufMTWaq60RdYZ+e1FLA5bO9RIg8jzkUvkzUcLJOTdsGYA6Q/HrZBVZNfqnx
 ECC1j82Dn7IH0CpAl0JEs8au8vQzeDCdZ1VVSrrS1fTEKlc3ffcQIrvYmp6c/A6XGW40
 LPdz/N1dc7KYpS22eN06LfAFxI6UaOp3jLr1dQ7wfgCGkoptLZSr492YQSTJ7P9BOIX7
 m+/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9osc6opUXllpjAtIgZV/ESUNs/DYycdCzXttkQ5NoOI8gjRlz6twOlMV5XQqvQcbPOcIc=@dpdk.org
X-Gm-Message-State: AOJu0YwywzBIQe4kUOo3dG6Q7y8N9VUHets1l1TX+ZKPCmdAG2hK3uXM
 aIXxU3g3htuwmfJeoJkyCpC3nyPJ03wEQUJyrpXOpUo3wfgUqKSN/WwL1WUdZ1odAoE=
X-Gm-Gg: Acq92OEWUO+iZVenuCltHXoh41WUOrjpJOo+5BCyg6KjWEqoyMH/59Gsd/AMe0bCEo3
 vyRgc8JkY/+lmlGf3qUsH52A3Vpgys49jE9ICp4t5qZIUM9JlV2wfM5xw2N6Wifl/Ns6TkVDgW9
 aGmtzVtmOKWjVonNZPOWh+pF3wD1+yuI/aF83avH9gccw/thTgVPXeTd0zEd7PS577mFYsUEmTx
 qiMY0wYCfshZvNcBqeOMp2981+JepBRj8bRyiO8p25GbzvCsKOgnzDRDrqOmgata9aJoN5Un2Wn
 wPnMUMyer2hgD5KjB2OojxssA+vMEGnDN8TO4elbRLtfx/bNOQ/xvf20T7VWbDQP7bv9zEZvSea
 TS4BzBQee96zGeGyetjcCCQMLMrRdH0jZqG5oNytS/bHBXcoK0tsf+FbFY0DXxGAK6GAm0EOvoD
 ZHrqiJTtliamHkkHd+UnsLj8v6lgURQM+LV/i9MtAgHiA8vJcZRWOUGJSy5Tds63HqSWMhQdtGB
 qU=
X-Received: by 2002:a05:7300:a44c:b0:304:cd0d:9ea5 with SMTP id
 5a478bee46e88-304fb1d469amr551510eec.7.1780095177855; 
 Fri, 29 May 2026 15:52:57 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm2611287eec.5.2026.05.29.15.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:52:57 -0700 (PDT)
Date: Fri, 29 May 2026 15:52:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] app/test: use memcpy in ipsec test
Message-ID: <20260529155254.6f563f48@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658B7@smartserver.smartshare.dk>
References: <20260529154651.128372-1-stephen@networkplumber.org>
 <cd2886ccd3134ab0a712e739bad4da5e@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658B7@smartserver.smartshare.dk>
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

On Fri, 29 May 2026 22:45:00 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > > @@ -604,22 +603,22 @@ setup_test_string_tunneled(struct rte_mempool
> > > *mpool, const char *string,
> > >  	/* copy outer IP and ESP header */
> > >  	ipv4_outer.total_length =3D rte_cpu_to_be_16(t_len);
> > >  	ipv4_outer.packet_id =3D rte_cpu_to_be_16(seq);
> > > -	rte_memcpy(dst, &ipv4_outer, sizeof(ipv4_outer));
> > > +	memcpy(dst, &ipv4_outer, sizeof(ipv4_outer)); =20
>=20
> How about:
> *dst =3D ipv4_outer;
>=20
> Don't know if it applies here.

Good idea but dst is char *.
I suppose could use a cast but at that point the good
properties of assignment disappear.

Didn't want to go changing other code.
