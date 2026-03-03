Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D2AEDA688
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 176C7402AA;
	Tue,  3 Mar 2026 16:21:22 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 3A9BA40268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 16:21:21 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2be1c918173so2523710eec.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 07:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772551280;
 x=1773156080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1G42PzYh1UGC8n3V/1k5/PfbZWDq4tw1wUvMjeFUo8=;
 b=gjb8sabZZcmGVh7lQ2wHw2+p7rmV5FgrkP6iN6KPqklfeBC4zdYJM0q0m+Mj2xB72Z
 Ky+gyKGZ21xpZfxq3LqLolrEekZKgmiI5LmxJNKUC7VS/q+mjFjpDc2+SlicaCyKQZH/
 jikmIAiuiPf20rFddH+0TdWWECBhxQS4sojd1YE6Pdw3da5oro3ujQV0VnJj3up0Os78
 7utZd8epkta+mKDOL/nWmjSvfKM0rSx8p+ikXY53PtoFVpPPkPBcQ0KMJVAzB7V7QLlv
 lIXMn0l+9sIVda61L4Ab6aDCqxKtzbKh7uUJ7bjEtiGQB7psEcWPscKe3GnOaifP45cC
 ftMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772551280; x=1773156080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b1G42PzYh1UGC8n3V/1k5/PfbZWDq4tw1wUvMjeFUo8=;
 b=smHxe+wqloQNU59wi62OQYsW1dJfb3BsE/Q290x6Z6CaG5s7k4+Ra1lVr/58qcH7W5
 ZsJTaRjT3dP7M3Hf43yLeqwGUtk3Zqj4JlMnlihTYgfHynnDWSEwaTkvx/3vVk0PT7vf
 7Hgf+7YgCaWA3vnAVqoqAuwTLMjVNv7dcNnOe56lD9eDwK1VTM/moxkGPry+MoHl6+9g
 ut2o814cNyciMLaI8+jCEAP4DyAnML2kELMmxHPoUsIl0nqkkI3Tn7LVTFP0yhwwC8En
 zJ9+q4og5DxWTy4C6Y9FW7te2VAkUufFvbnX2jc2GjeTBbHposTKbFvGwpLAkCi6Rth5
 MyeA==
X-Gm-Message-State: AOJu0YwIqkBDkKdhlq3wwvMIp7vVlZrH13KTAUmknY/DmDFxLW1AUOfr
 oxo/+IwjjllmSclREzRvvLAlDQ2VZgVIBNxLUYCuOUyLupTy/N8mrt5HS1cZv8TNFN8=
X-Gm-Gg: ATEYQzzA/ZR0v1E+vgI9vkyqmg83gugDtWLlqsXwJYn+wGKtbBSFuVQW5jR6w4twu/T
 i2ZIlemv4NYhrrY8jCiMGhstOuek8OTASAODKWsEq1s3YHDwlO2QmMPHezuuPkqSIqGk4wCAlF1
 9IibGIWDggobFolS6qJnRZ242o/XBjXhJWXLQSxRrRyGUx0lnmHj4E25gjdJLvTPx62sYwSEb/a
 wSpk0Ps+e5/qb3R6JqnzQXj7gQSrrCFYyX5GK9I+hdUiQntfPptU8GBafLr6/Dh8X1Bi5LyRcYQ
 M1yTGhZOLHL8VpIGkn1zBOZ1ExQmEMZBSwamQInDRvupwxNyFMcw2MIx92fVVWloE/2AIUktsIN
 x3t8NLiEXepu3GbGacv7G4b35fFU7K9PKuL0SLvVVLEyXiB/bbWyBTBrP71VeoOJCv7glxI1bba
 AGO6ufArobs4IxRWE90p8LwnIAoPj0QN+XmUzdpFcUurv8S/CAGiKNwifwRHn7tC+1
X-Received: by 2002:a05:7300:cd90:b0:2b7:2bf3:ce05 with SMTP id
 5a478bee46e88-2bde1e84307mr6484790eec.28.1772551279986; 
 Tue, 03 Mar 2026 07:21:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be2c357d6bsm47582eec.20.2026.03.03.07.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:21:19 -0800 (PST)
Date: Tue, 3 Mar 2026 07:21:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/4] net/gve: add flow steering support
Message-ID: <20260303072116.37d58a4f@phoenix.local>
In-Reply-To: <20260303005804.924545-1-jtranoleary@google.com>
References: <20260227195126.3545607-1-jtranoleary@google.com>
 <20260303005804.924545-1-jtranoleary@google.com>
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

On Tue,  3 Mar 2026 00:58:00 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> This patch series adds flow steering support to the Google Virtual
> Ethernet (gve) driver. This functionality allows traffic to be directed
> to specific receive queues based on user-specified flow patterns.
>=20
> The series includes foundational support for extended admin queue
> commands needed to handle flow rules, the specific adminqueue commands
> for flow rule management, and the integration with the DPDK rte_flow
> API. The series adds support flow matching on the following protocols:
> IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.
>=20
> Patch Overview:
>=20
> 1. "net/gve: add flow steering device option" checks for and enables
>    the flow steering capability in the device options during
>    initialization.
> 2. "net/gve: introduce extended adminq command" adds infrastructure
>    for sending extended admin queue commands. These commands use a
>    flexible buffer descriptor format required for flow rule management.
> 3. "net/gve: add adminq commands for flow steering" implements the
>    specific admin queue commands to add and remove flow rules on the
>    device, including handling of rule IDs and parameters.
> 4. "net/gve: add rte flow API integration" exposes the flow steering
>    functionality via the DPDK rte_flow API. This includes strict
>    pattern validation, rule parsing, and lifecycle management (create,
>    destroy, flush). It ensures thread-safe access to the flow subsystem
>    and proper resource cleanup during device reset.
>=20
> Jasper Tran O'Leary (2):
>   net/gve: add adminq commands for flow steering
>   net/gve: add rte flow API integration
>=20
> Vee Agarwal (2):
>   net/gve: add flow steering device option
>   net/gve: introduce extended adminq command
>=20
>  doc/guides/nics/features/gve.ini       |  12 +
>  doc/guides/nics/gve.rst                |  26 +
>  doc/guides/rel_notes/release_26_03.rst |   1 +
>  drivers/net/gve/base/gve.h             |   3 +-
>  drivers/net/gve/base/gve_adminq.c      | 118 ++++-
>  drivers/net/gve/base/gve_adminq.h      |  57 +++
>  drivers/net/gve/gve_ethdev.c           |  83 +++-
>  drivers/net/gve/gve_ethdev.h           |  46 ++
>  drivers/net/gve/gve_flow_rule.c        | 656 +++++++++++++++++++++++++
>  drivers/net/gve/gve_flow_rule.h        |  65 +++
>  drivers/net/gve/meson.build            |   1 +
>  11 files changed, 1063 insertions(+), 5 deletions(-)
>  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
>  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h
>=20

Automated review spotted a few things:

1. rte_bitmap_scan usage is incorrect.
2. Using rte_malloc where not necessary
3. Grammar in the release note.

I can fix the last one when merging, the second one is not a big issue
but would be good to have.

---


Error: Incorrect rte_bitmap_scan usage =E2=80=94 wrong rule ID allocation (=
~85% confidence)

In gve_create_flow_rule():
c

uint64_t bmp_slab __rte_unused;
...
if (rte_bitmap_scan(priv->avail_flow_rule_bmp, &flow->rule_id,
        &bmp_slab) =3D=3D 1) {
    rte_bitmap_clear(priv->avail_flow_rule_bmp, flow->rule_id);
}

rte_bitmap_scan() writes the slab base position to pos and the slab bit pat=
tern to slab. The actual bit position of the first available rule is pos + =
__builtin_ctzll(slab), not pos alone. The __rte_unused annotation on bmp_sl=
ab confirms the slab value is being ignored entirely.

After the first rule allocation clears bit 0, a subsequent scan returns the=
 same slab base (pos=3D0) with bit 0 now clear in the slab. The code would =
again set rule_id=3D0 and attempt to clear an already-clear bit, then try t=
o create a duplicate rule on the device.

Suggested fix:
c

uint64_t bmp_slab;
uint32_t pos;
...
if (rte_bitmap_scan(priv->avail_flow_rule_bmp, &pos,
        &bmp_slab) =3D=3D 1) {
    flow->rule_id =3D pos + __builtin_ctzll(bmp_slab);
    rte_bitmap_clear(priv->avail_flow_rule_bmp, flow->rule_id);
}

Warning: rte_zmalloc used for ordinary control structures

Both avail_flow_rule_bmp_mem and individual gve_flow structures are allocat=
ed with rte_zmalloc, but they don't require DMA access, NUMA placement, or =
multi-process shared memory. Standard calloc/malloc would be more appropria=
te and wouldn't consume limited hugepage resources.

Warning: Release notes tense inconsistency
rst

* Added application-initiated device reset.
+ * Add support for receive flow steering.

"Added" (past tense) vs "Add" (imperative). Both entries should use the sam=
e tense for consistency. The DPDK convention is imperative mood.

