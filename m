Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3609EC43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D08940264;
	Tue,  7 Jul 2026 13:23:34 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 07ECD4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 13:23:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gvf2x4zpFzHnH4m;
 Tue,  7 Jul 2026 19:22:33 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id BD29A40575;
 Tue,  7 Jul 2026 19:23:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 13:23:31 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 7 Jul 2026 13:23:31 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 0/8] doc: build for all public headers
Thread-Topic: [PATCH v3 0/8] doc: build for all public headers
Thread-Index: AQHdDe3YkeNxlfBY1kq0Qsvuf2iMwbZh38dw
Date: Tue, 7 Jul 2026 11:23:31 +0000
Message-ID: <b071c236c8c74b7faecf8efd4da1f46b@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
In-Reply-To: <20260707085048.15295-1-marat.khalili@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Will answer the AI code review comments here.

> ## Patch 1/8: doc: detect ignored public headers
>=20
> ### Errors
>=20
> **Error: Resource leak in meson.build `run_command()` usage**
> The `run_command()` calls capture stdout into variables (`doc_built_dirs`=
, `doc_indexed_headers`) but
> there is no error handling for the command execution itself beyond `check=
: true`.
> If the `sed` command fails partway through (e.g., file read error, permis=
sion issue), the script
> continues with potentially incomplete data.
> While `check: true` will cause meson to fail, the failure mode is not gra=
ceful.

Requirement for the setup to survive unreadable source files is clearly exc=
essive.
And meson reports specific command that failed quite well already.

> ### Warnings
>=20
> **Warning: Hardcoded meson version check without rationale**
> Line `check_docs =3D is_linux and meson.version().version_compare('>=3D 0=
.60.0')` introduces a version
> check for meson 0.60.0 without explanation.
>=20
> **Suggested fix:** Add a comment explaining why meson 0.60.0 is required =
(likely for `fs.name()` or
> another feature used in the check).

Meson prints source lines and versions required during the setup already.
Not sure who would ever benefit from this comment.

> **Warning: `run_command()` assumes specific sed implementation**
> The `sed` commands use `--regexp-extended` which is a GNU sed extension.
> On systems with BSD sed (macOS, FreeBSD), this will fail.

The check is explicitly limited to Linux.

> **Warning: Global variables `doc_built_dirs` and `doc_indexed_headers` la=
ck context**
> These variables are set in the top-level `meson.build` but used in `drive=
rs/meson.build` and
> `lib/meson.build` without clear documentation of their contract.

The names are self-descriptive IMO.

> ## Patch 3/8: doc: fix typos in rte_avp_common.h
>=20
> ### Warnings
>=20
> **Warning: Missing closing brace on line 271**
> Line 271 adds `@{` for "Access AVP device version values" but there is no=
 corresponding `@}` to close
> this group.
> All three macros that follow (`RTE_AVP_GET_RELEASE_VERSION`, etc.) will b=
e grouped, but the group is
> never closed.

Grouping commands are imbalanced in the file now, so the patch has to have =
them
imbalanced for the result to be balanced. Instead of the patch the AI revie=
wer
should have checked the resulting file or the fact that it builds.

> ## Patch 5/8: doc: fix typos in rte_bus_vmbus.h
>=20
> ### Warnings
>=20
> **Warning: Incomplete parameter documentation in `rte_vmbus_chan_send_sgl=
ist()`**
> The function takes a `flags` parameter (visible in the function signature=
 in the actual driver code),
> but the patch removes `@param flags` from the documentation without verif=
ying that the parameter does
> not exist.

Not sure how the model checked the function signature, but the parameter do=
es not exist.
Which is why documentation failed to build before and builds now.

> **Warning: Parameter name mismatch in `rte_vmbus_chan_recv_raw()`**
> Documentation refers to `@param channel` but the actual parameter name is=
 `chan` (as used in the
> corrected version).
> This is fixed by the patch, but worth noting for consistency checks.

The model notes the discrepancy that the patch already fixes.

> ## Patch 8/8: doc: add missing headers to doxy-api-index.md
>=20
> ### Warnings
>=20
> **Warning: BPF list formatting inconsistency**
> Lines 219-223 introduce a nested bullet list for BPF headers:
> ```markdown
>   [member](@ref rte_member.h)
>   * BPF:
>     [load and execute](@ref rte_bpf.h),
>     ...
> ```
> This creates a sub-list with only one parent item.

Nested bullet lists are used in other places in the file and even in the sa=
me patch,
seem to be a good practice actually. Not sure what "only one parent item" m=
eans.

> **Warning: Comma inconsistency in "containers" section**
> Line 231 adds `[member](@ref rte_member.h)` followed immediately by a new=
 bullet for BPF, but previous
> list items in the same block end with commas.

Customary in the file last item in the list does not end with a comma.
The rendering was verified in the web browser.

> ---
>=20
> ## Summary by Patch
>=20
> | Patch | Errors | Warnings | Info |
> |-------|--------|----------|------|
> | 1/8   | 0      | 3        | 0    |
> | 2/8   | 0      | 0        | 1    |
> | 3/8   | 0      | 1        | 0    |
> | 4/8   | 0      | 0        | 0    |
> | 5/8   | 0      | 2        | 0    |
> | 6/8   | 0      | 0        | 0    |
> | 7/8   | 0      | 0        | 1    |
> | 8/8   | 0      | 2        | 0    |

Interestingly, the one found Error did not make it to the table.

This error and all 8 warnings are addressed above and not the actual proble=
ms.
