Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA59FED9E8
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B0EE402B0;
	Tue, 17 Mar 2026 17:20:49 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 1B65740270;
 Tue, 17 Mar 2026 17:20:48 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 687D21D00103;
 Tue, 17 Mar 2026 12:20:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 12:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773764447;
 x=1773850847; bh=p5lSVqg+CrdmzfiY7gDbr+8jrFOnNPJp9zw6d7zpWHg=; b=
 HHDK7UNbhkYjcf7MTlCM25FOwgBUf/o6jpwGf/DDVnk7q2KwhW83mjFc/vu7PPkA
 9knc7N9h7NAN9XqFElbf3i1A4SWeJyjt+k1iL4LLoHRFAS9N3wqH3Ou74uev+w+s
 y6qtacfhVitnlHxHxYpmQbIXrotcSiR9/PeutWnS9KaUNOlnCweUSlFMLl/YvkJT
 lGg7xGH6sHGAjTjxciZQSb3JrRKHH4U8GkgFtT4wPsJNgkctf2xOzGRRxoy7RZdR
 DS4SkgPKCLP1SAGpEb7ZgMSOQk1yQuOXIW2HxKlpQGXpof3QtQXSphDmpcyvIelJ
 P3w9gzqk3LrChruhlER5Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773764447; x=
 1773850847; bh=p5lSVqg+CrdmzfiY7gDbr+8jrFOnNPJp9zw6d7zpWHg=; b=Q
 BrrjMo/EtJnin63qI7VA8uEvJ5+G7nmK5TPudAxj3Xc/0AWrAKBR5p6ubuoNB+BP
 9SE0VK0x9E5uBBjeZUnrovVUf6WS4rfRyc1d6UAaRHmk/O6qhduZGfCXl2qn4gVD
 GPFEmkn8VL7Bx1JescTkK+fi0i3ShbESA1YskedOBC/a3ghVjrEzvLmKYr3lN/HE
 eQuU7xcdzZHwFmnsLELp7RrM5xypcnBj+5GAniiNDv8jtQm4BhvxEeHInfE5JNTJ
 PYlAyasBZk38fpfyVh7awItGJtvNG/CgKg9We+qHteqPca07UJiiyiyBufaXc19z
 bXofe+CU8XCrjOc/9rPZQ==
X-ME-Sender: <xms:X3-5actySZ2lJW09GQXNS4EsL3lq20TCxyb7uSkNSOLrNjfQ4grhlg>
 <xme:X3-5aQ25lOAT2ng12iZyThFt61iGn2gVQhcAbxWHK5MS_NmwspR9QVPyDmuC1apn_
 0Ok_X2j8dJk8AG4c-2cAGoBWpM_EmZoslrrWHPmEAZFNoQF1ZjGDg>
X-ME-Received: <xmr:X3-5adV8XhrgPlAX2Pvs1odRNMqWBbtj_3Tzl1zLHma-_lwlqrRdGcv7K7TQo6gVnUHg_25yq45QtulJawU0NvMzMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhi
 ugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhgpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhn
 thgvlhdrtghomhdprhgtphhtthhopegurghvihgurdhhuhhnthesihhnthgvlhdrtghomh
 dprhgtphhtthhopehsihhvrghprhgrshgrugdrthhumhhmrghlrgesrghmugdrtghomh
X-ME-Proxy: <xmx:X3-5abJgAtTZJEv5-8-x4QE--lhZEkJ10vd96dq9jBj_vZziFeQjRw>
 <xmx:X3-5af2FqnbptXg9X_OEKUb6qCBrSjL_bljSqmElBl3GWz4cfRZasQ>
 <xmx:X3-5aR4v7e3Dwp1DakvGxdCRbqFLrEpT3zZCaOinq6IrvvZMNnad5Q>
 <xmx:X3-5aY9jRyxYlvjpljoW6lsNJq_XCfnlzYAHUVLgZUAr3Vah1A24-w>
 <xmx:X3-5aYPyn3ykjeoyvJ-_6UXglCSkAWWsHHEPwcNtl1UwgoS3MRcUbhqY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:20:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] examples/vm_power: fix format-truncation warning
Date: Tue, 17 Mar 2026 17:20:44 +0100
Message-ID: <2637349.4XsnlVU6TS@thomas>
In-Reply-To: <20260225173632.283928-1-ktraynor@redhat.com>
References: <20260225173632.283928-1-ktraynor@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

25/02/2026 18:36, Kevin Traynor:
> Without libbsd-devel strlcpy is defined as rte_strlcpy and a warning is
> raised for format-truncation. Observed with gcc 15.2.1.
>=20
> In function =E2=80=98rte_strlcpy=E2=80=99,
>     inlined from =E2=80=98add_host_channels=E2=80=99 at
> ../examples/vm_power_manager/channel_manager.c:600:3:
> ../lib/eal/include/rte_string_fns.h:63:24:
> warning: =E2=80=98%s=E2=80=99 directive output may be truncated writing u=
p to
> 4095 bytes into a region of size 108 [-Wformat-truncation=3D]
> 63 |         return (size_t)snprintf(dst, size, "%s", src);
>    |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Check for truncation of socket_path[4096] into channel_path[108] to
> remove warning.
>=20
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

Applied, thanks.



