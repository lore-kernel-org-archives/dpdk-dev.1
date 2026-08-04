Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E913C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 16:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4A3940685;
	Tue,  4 Aug 2026 18:31:51 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id BC44D40616
 for <dev@dpdk.org>; Tue,  4 Aug 2026 18:31:50 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc97653887so693045ad.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785861110;
 x=1786465910; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3NkuzJEF6KGs4LdLtITDiNoVID53P6M0xJ4I7PcpqdQ=;
 b=QiNbxOsNSc4N507JYYKn+1lukMqCoO6lBBx1vIK3sQxcQd6N/SslcW7Qm/4QHYn9yx
 43PTaFHsdwT+DCr8eYoAL2KeSkups5QpykOOU3hjrK5BtiOnP6gM5//Jh+oFEhdj3ail
 /7uIqMDOvyvWNFMNgZQGdlRfkUQaoKO7ZLvphQCe2Aans+TTzvgDHMJoAFtGZxiNZwTi
 hSCXYgkUA2m2th2+u2uMsgq01aK+CDSCEFVkgQU2jc117c1Ahnkz09dU0q0/1n8QIW5p
 R0CletzHQ2VNJ+r3kPLip+SJC0ORGt24yU9ppkLANA4GSzaU1Nfe3qO3E84sRZivHBLm
 l4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785861110; x=1786465910;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3NkuzJEF6KGs4LdLtITDiNoVID53P6M0xJ4I7PcpqdQ=;
 b=KbZz5sMt8c27RlLQTXRmgn5LDfBGzHPKRJPuIGT4D214sDy4GRVcKoF3hSomHxgUMZ
 LSkyGdDogPH09EBoaQpCxN54SLSQgeSIYG+8LqKaeM4AxU8Tv2HKi927eC9Yiv4jCLU8
 Jo4F7t6lOnGLY/M9dVa/o/BlVFe5yHz0hFbni/bSLkce5SIYfRed58tcDxROYt2s1KkB
 lVwEF+T7YTVLF2BgzSSGPhQqlX8Y442bfY47v44QLlN8tHIeufKay/xJ8SVVp6ZAjwyr
 P2LtBLArRct1v01I0TKpf8g0MHcTpQwBIIn9f9WrJPFhdC8vx3y0yNMlLtTEb6juw/nF
 bJIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrM/J/9fL85Re6n572QiDGzzUDOhefvmjYgJGPXRQXzeeld1cOaZGz8FyvXjUbIWDQKFkU=@dpdk.org
X-Gm-Message-State: AOJu0YziO7VOzyuMW66G1td0WT/GXXaT30u+Q33/zHrUIb2iziAUxpPY
 m+66mIswOIZ8fa7yUPuNfHh8bGMdUodVnX0+f8O7bs4VA7QbYEcDN4L2/oF+l883sfw=
X-Gm-Gg: AR+sD12++wtQIIZw+q9UEcgo/4W9hi/2J+MbHi/m4j6idp0B8ve86NNGsAx4cC8Cd2w
 md22HHE2isoq0+fFLRrJwQy/Ypk8rze058eV5ZzpwhfgWcsS9eqr81HSGPllnjvm+u4HqeQSjYp
 2SVaXD202mEEQmzQfy+JUQHQW4DKhat9gxYt+jEKjnvggxAJkwBRMZB3i4bmVwtm4WbC8xJ3TAo
 lRxVvOJkpQkVrBb/K6oVnNU0OcQUI6ZR1ksngJ7MbAd+JwANEM89A4vyAi8/F1+ytk/riXeHTge
 QuHvP+T0Aqv9rYs3V7ctzHewis8C3LchlpEG+Q+VixwrIkBPJUcNVueeXmXBHYMFmTQEnPO+28e
 2sEOHrMYyvZwmVGbJDV+z0EgvhX/dtfB/C2ibOw6DOykYfFe1O+U6IWbw519y3xKgC0AUFsR73z
 jr5IF0ZyIUEAHL58XiiRscx5Un9g5YoX5Mnhb0SBmJuqyYaaaJvzOe1asD4ygfkSjVhO9iNNG8S
 nDU+F19eOXC7qnuSyKdyFQbhdks7Q==
X-Received: by 2002:a17:903:2409:b0:2c9:aae1:a61a with SMTP id
 d9443c01a7336-2d0ca77f02fmr584255ad.14.1785861109632; 
 Tue, 04 Aug 2026 09:31:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm9140043eec.2.2026.08.04.09.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 09:31:49 -0700 (PDT)
Date: Tue, 4 Aug 2026 09:31:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 sriram.yagnaraman@ericsson.com, dev@dpdk.org, bingz@nvidia.com,
 rasland@nvidia.com, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>
Subject: Re: [RFC 0/5] fix and complete the eCPRI header
Message-ID: <20260804093145.77db5df4@phoenix.local>
In-Reply-To: <20260804081319.1869087-1-hofors@lysator.liu.se>
References: <20260804081319.1869087-1-hofors@lysator.liu.se>
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

On Tue,  4 Aug 2026 10:13:14 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> From: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
>=20
> The objective of this series is to make rte_ecpri.h a complete and
> correct description of the eCPRI V2.0 message headers, usable for
> parsing and building messages, and not only for matching on a few
> header fields with rte_flow, which is what it was added for.
>=20
> The first two patches fix wire format bugs in rte_ecpri.h: missing
> fields in the One-Way Delay Measurement message header, and padding in
> the Remote Reset one. Both change struct sizes, hence the release note
> entries and the lack of a stable tag.
>=20
> The rest completes the eCPRI V2.0 coverage of the header.
>=20
> Mattias R=C3=B6nnblom (5):
>   net: fix eCPRI delay measurement message header
>   net: fix eCPRI remote reset message header size
>   net: add missing eCPRI message field values
>   net: allow byte swapping eCPRI remote memory access
>   net: add eCPRI IWF message headers
>=20
>  doc/guides/rel_notes/release_26_11.rst |   8 ++
>  lib/net/rte_ecpri.h                    | 164 +++++++++++++++++++++++--
>  2 files changed, 159 insertions(+), 13 deletions(-)

More detailed AI review (the CI one is really pretty dumb).
TLDR: missing/lack of deprecation notices.

Applied cleanly on c1a46b9 (26.11.0-rc0). Built with -Dwerror=3Dtrue and
net/dpaa2 + net/bnxt enabled (the two in-tree consumers of the changed
structs) plus testpmd: no warnings. Per-commit compile of dpaa2_flow.c,
ulp_rte_parser.c and cmdline_flow.c at each of the five commits is also
clean, so the series is bisect safe.

Measured layouts after the series:

  rte_ecpri_msg_delay_measure  size=3D20 align=3D1
      msr_id=3D0 act_type=3D1 ts_sec=3D2 ts_nsec=3D8 comp_val=3D12
  rte_ecpri_msg_remote_reset   size=3D 3 align=3D1  rst_id=3D0 rst_op=3D2
  rte_ecpri_msg_rm_access      size=3D12 align=3D4  addr=3D4 length=3D10
  rte_ecpri_msg_iwf_up         size=3D 9 align=3D1
  rte_ecpri_msg_iwf_opt        size=3D 4 align=3D2
  rte_ecpri_msg_iwf_map        size=3D 4 align=3D2
  rte_ecpri_msg_iwf_dctrl      size=3D12 align=3D4
  rte_ecpri_combined_msg_hdr   size=3D24 align=3D4

Every size and offset claim in the commit messages and the release notes
holds, including "the layout, the size and the field access are all
unchanged" in 4/5 and "keeps its size" in 5/5. dummy[5] bounds the union
exactly again. The only in-tree users of dummy[] touch dummy[0], and the
offsetof() uses in dpaa2 land on unchanged offsets, so nothing breaks at
source level. The Fixes tag is correct: d164c609e70b is the commit that
added lib/librte_net/rte_ecpri.h along with the flow item.

Patch 1: net: fix eCPRI delay measurement message header

Error: ABI break with no deprecation notice. There is no eCPRI entry in
doc/guides/rel_notes/deprecation.rst, neither in this series nor in tree.
abi_policy.rst is explicit that the .11 breakage window "is *not*
permission to circumvent the other aspects of the procedures to make ABI
changes ... 3 ACKs of the requirement to break the ABI and the observance
of a deprecation notice are still mandatory". The ABI Changes template in
the release notes says the same thing ("which was announced in the
previous releases"). As posted this targets 27.11, not 26.11, unless the
techboard grants an exception.

Worth spelling out the concrete breakage in the notice, because this is
not just a formality. rte_flow_conv_copy() uses rte_flow_desc_item[].size,
which is sizeof(struct rte_flow_item_ecpri). That becomes 24 bytes, so a
new library memcpy()s 24 bytes out of a 16-byte spec allocated by an
application built against the old header, an 8-byte out-of-bounds read.
All existing field offsets are preserved, so that is the specific hazard
to cite.

Warning: the reason for the missing stable tag is only in the cover
letter, which is not preserved in git history. Someone doing LTS triage
later sees a Fixes tag with no Cc: stable@dpdk.org and no explanation.
Please move that reasoning into the commit message, and say plainly that
the bug stays live on the LTS branches because the fix cannot be
backported.

Info: the Compensation Value is documented here as "in units of 2^-16 ns"
while delay_a/delay_b in 5/5 are documented as "in 1/16 ns". Those differ
by a factor of 4096, so one of them looks like a typo.

Info: please add static_assert on the size, and ideally the alignment, of
the packed structs. rte_ether.h already does this:

  static_assert(sizeof(struct rte_ether_hdr) =3D=3D 14, ...);
  static_assert(alignof(struct rte_ether_hdr) =3D=3D 2, ...);

Three structs in this series now depend on __rte_packed_begin producing
20, 3 and 9 bytes respectively, and MSVC handles pragma pack and uint8_t
bitfields on its own terms. There is no eCPRI test anywhere in app/test,
so the wire layout is otherwise entirely unverified. This is the addition
I would most like to see.

Patch 2: net: fix eCPRI remote reset message header size

Error: same missing deprecation notice as 1/5.

Warning: same stable tag rationale as 1/5.

Patch 3: net: add missing eCPRI message field values

Warning: eleven new macros in an installed header with no release note.
One "New Features" entry covering the eCPRI V2.0 header completion, for
this patch and 5/5 together, would be enough.

Patch 5: net: add eCPRI IWF message headers

Warning: four new public structs and six new macros with no release note.
See 3/5.

Info: I could not verify the line_rate:5 / res:1 / s:1 / f:1 bit ordering
in rte_ecpri_msg_iwf_up against eCPRI V2.0 figure 31A. Please confirm that
byte. The uint8_t bitfields themselves are fine, rte_geneve.h and
rte_gtp.h set the precedent.

Info: 5/5 says the combined header keeps its size but does not say why
iwf_up is packed while the other three IWF structs are not. Without
packing it would be 12 bytes rather than 9. A sentence in the commit
message would save the next reader the arithmetic.
