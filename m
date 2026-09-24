Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C23AC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 15:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E941940611;
	Thu, 24 Sep 2026 17:31:06 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 9217D40144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 17:31:05 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so7119a91.0
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790263864;
 x=1790868664; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9LIOpTGLYOP7vL3+kgVrMy0eS5u2YJlJ0R1tyD8SY/M=;
 b=jkN2WG1TVF7wUiyMFE8uWrptpMCYxp/X4WczE+2MZY/Aku0LJk4VhwdbcPKEvyRW3G
 Br18V5CWMvTDfGmRmOvr3lTVFPN5W4gF5bg9z5dJA8k52XrGXgC6F+2TOcNup0UYlreN
 GRVZ6/YBEfER6dKIJlZBhX5t9wmJIjEfR63u2jGlDrn/vmuZ2Y053TeiFTym87LnPQpt
 /gslY6Ga3Ked5tiRVV4BsvASmivY8TxJU6Uv4gSqvpiYLW7T3LQ8Es5qUx2ZN1XEzyok
 KkbGBnDltlUjlPz8LAVxzCCIJtKJq8Xc7qjkiQgLZGe8DgYYK9JrxSVS2fdRHDD+ddFM
 TxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263864; x=1790868664;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9LIOpTGLYOP7vL3+kgVrMy0eS5u2YJlJ0R1tyD8SY/M=;
 b=GjPFEqjV3Su1yumm7Kv/EKRy+cEzYJ8M2peklzMjhU//Vr+IdvLKGTyPBRJed0s+PA
 WLJieNsIk+7Y4eRyPoWjKYuR/BzLl2AJLZZO8Av8aSnYdsIZmofWMwJyKLRr111trV7+
 NX4IjhrWDeBjnPSW+j9D1GP0MbfPgEq8mrJ5E0Us6xQVMXncmdEh2s9BkpIbt2+FRJvq
 0tY8Ex/t5/a7KOYapb5fhHZEZCBgFba5hXfdozxue5g5mBJ2QbpDyUnTdOhvXFQhEh+k
 +0ua2Rxv+q1BiweBrdHFanreLkIE76nenNeOw0UAJeRftYaRJ2TvyAoachdiTsCO7yGK
 LOFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0HRb0gn4ZYjSxkIZnvpTH6bSEpb4W7PuToEhsSx+HBctHDapP4q4w/nk3JBkuZWtekdo=@dpdk.org
X-Gm-Message-State: AFuF++k3d5ex9nOA2psUApfLL0KuKPia3FKLu6+t6e9AcrjQ60pEnHBq
 PZ96FuCV8jB5ae5hHSvmXexE472Vr74bWRPCbMrVYRJuPrJFqrFwA+259evjudMumis=
X-Gm-Gg: AYBFou0D2WtJ95f3/El6tGKBHLcUxRxFlsC09M9Ft/WfhD0kZwdvUMlj0AbIcDMp59s
 5q+64Q26GdaXzGmmZBZzND6O5AMKqurCXuynhqYNZ7vMK91v2i/wDfHkL/s74srx/F6Bs8yvwj7
 mSO5F+jZBS6KBJMvq5aYrHC9+JmG6iWk0/f7coW9Z/4DUmiEiKXL6mV5oWjsQRHYqsazQUMVpZW
 h+iuN0OJZ5wcUW2JkDe36X4P8grzFnRqhfdkcvvyASzmgt895+Ygd7t3itZK5qbf2C9u8kW4syN
 VSA27VYTs8vQSA6AkggxAcm7kK0t6JHEeVWlBGeOrs1zOw8h/2RTei2wpqN8asOYhzg2CowEZm0
 XRqk2jLWD7c20QGcgtaVYSjB5BG1OPRuH10HnlWZrjTUHHWJ+SjczSJCFH3keGoz8nx7b7G77fl
 LUdAtGG9cmiVDCkB4ncyf53qHqq2QGGv8WMZ0Pg0fPkVX0LWxYw2ysLBurIvfjFJA4JxorcUxMi
 0BnUzrFmGDyqJEgnMDMqrEDtgn7bikMu+5LD8GLD56D8FABuGI=
X-Received: by 2002:a17:90b:5247:b0:39e:6c68:fd8f with SMTP id
 98e67ed59e1d1-3a098b628d9mr1726753a91.36.1790263864073; 
 Thu, 24 Sep 2026 08:31:04 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3d5ce8sm2836773a12.17.2026.09.24.08.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:31:03 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:31:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, Aaron
 Conole <aconole@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [RFC] devtools: rewrite doc vs code check in Python
Message-ID: <20260924083102.7c0d946b@phoenix.local>
In-Reply-To: <IyiA4StYRHSdTGPuf2hfGQ@monjalon.net>
References: <20260923184207.626576-1-stephen@networkplumber.org>
 <20260923135430.7e16c673@phoenix.local>
 <arTSOhHVEOKr7U06@bricha3-mobl1.ger.corp.intel.com>
 <IyiA4StYRHSdTGPuf2hfGQ@monjalon.net>
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

On Thu, 24 Sep 2026 10:36:42 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 24/09/2026 09:33, Bruce Richardson:
> > On Wed, Sep 23, 2026 at 01:54:30PM -0700, Stephen Hemminger wrote: =20
> > > On Wed, 23 Sep 2026 21:19:45 +0200
> > > Thomas Monjalon <thomas@monjalon.net> wrote:
> > >  =20
> > > > 23/09/2026 20:42, Stephen Hemminger: =20
> > > > > The existing check-doc-vs-code.sh only compares rte_flow items and
> > > > > actions, and only for drivers whose directory matches the ini nam=
e,
> > > > > so none of the drivers under net/intel are checked.
> > > > >=20
> > > > > Replace it and parse-flow-support.sh with a Python script covering
> > > > > the whole NIC feature matrix:   =20
> > > > [...] =20
> > > > >  devtools/check-doc-vs-code.py          | 1132 ++++++++++++++++++=
++++++
> > > > >  devtools/check-doc-vs-code.sh          |   84 --
> > > > >  devtools/parse-flow-support.sh         |   92 --
> > > > >  doc/guides/contributing/new_driver.rst |    4 +-
> > > > >  doc/guides/contributing/patches.rst    |   27 +
> > > > >  doc/guides/nics/features.rst           |    5 +
> > > > >  8 files changed, 1169 insertions(+), 180 deletions(-)
> > > > >  create mode 100755 devtools/check-doc-vs-code.py
> > > > >  delete mode 100755 devtools/check-doc-vs-code.sh
> > > > >  delete mode 100755 devtools/parse-flow-support.sh   =20
> > > >=20
> > > > Thanks for working on it.
> > > >=20
> > > > My concern is how easy it is to maintain for all contributors
> > > > having to insert their rules and exceptions?
> > > >=20
> > > > It is replacing less 200 lines with more than 1000 lines
> > > > so it looks a lot more complex.
> > > > It is probably fully generated by AI?
> > > > Can we make it simpler?
> > > >=20
> > > >  =20
> > >=20
> > > The other suggestion would be to git rid of the .ini file method
> > > of generating this feature matrix in doc and just have python script
> > > generate it.  Prefer a single source of truth, less work =20
> >=20
> > +1, I was just going to suggest that when I saw the discussion on this
> > script.
> > In case of autogeneration, for cases like "partial" support, we can hav=
e a
> > well-defined comment tag or similar in the code to mark it. =20
>=20
> I agree with this direction.
>=20

The plan AI generated is:

# DPDK NIC feature matrix: generator concept

Handoff note for resuming in a new session.
Branch `doc`, worktree /home/shemminger/DPDK/doc.

## The idea

Today the NIC feature matrix is a **hand-maintained cache of facts that are
already knowable from the code**. That is what produced ~448 doc-vs-code
findings: the cache went stale.

Replace it. Instead of checking docs against code, **generate the doc output
from the code** using the same rules.

Split the current `devtools/check-doc-vs-code.py` into two tools with
genuinely different jobs:

1. **generator** =E2=80=94 code -> RST table directly. No `.ini` files at a=
ll.
2. **`check-ethdev-ops`** =E2=80=94 a linter for *driver code* self-consist=
ency.
   Nothing to do with docs.

The second tool matters because many current "findings" are **not doc bugs =
and
cannot be fixed by editing docs**:

    ena:   stats_get without stats_reset
    ntnic: mac_addr_add without mac_addr_remove
    pfe:   allmulticast_enable without allmulticast_disable
    mlx5:  flow_ctrl_get only returns an error, leave it NULL
    nfb:   fec_set without fec_get_capability
    xsc:   Rx timestamp offload without read_clock

Those are driver defects. The `OP_PAIRS` and `CODE_IMPLIES` tables already =
in
the script are `check-ethdev-ops` in embryo =E2=80=94 lift them out roughly=
 as-is.

## Current pipeline

    code -> (75 hand-maintained .ini) -> conf.py -> RST table

- `doc/guides/conf.py:168` `generate_overview_table()`, called **22 times**
  across **8 device classes**.
- Feature dirs: nics, bbdevs, vdpadevs, regexdevs, compressdevs, gpus,
  cryptodevs, eventdevs.
- **Only nics has rules.** The other 7 classes have no code-derivation rule=
s,
  so `conf.py` must keep the ini path for them. Two mechanisms will coexist
  unless that is also tackled. This is an open scoping question.

## Is the nics table fully derivable? Yes (measured)

    Features        78 rows:  68 via RULES + 10 platform via meson -> 0 unc=
overed
    rte_flow items  68 rows:  scan RTE_FLOW_ITEM_TYPE_* tokens
    rte_flow actions 66 rows: scan RTE_FLOW_ACTION_TYPE_* tokens

`check-doc-vs-code.py -g <driver>` already generates a full ini and runs
cleanly for all 75 drivers. The machinery largely exists.

## CRITICAL: naive generation REGRESSES the docs

Generated vs committed across all 75 inis: **only 1/75 match**.
Totals: **+811 rows / -165 rows / ~160 value changes.**

Three distinct causes, each needing a fix before output is publishable:

### 1. Platform rows (~300 bogus additions)
Generator adds `LoongArch64` to 66 drivers, `rv64` to 65, `Power8` to 61,
`ARMv7` to 54 =E2=80=94 solely because meson does not *exclude* them.

**"Not forbidden to build" !=3D "supported".** Publishing this asserts test=
ed
support that does not exist. Counter-example already in tree: `af_xdp.ini`
deliberately lists only `x86-64` though meson allows every arch.

Fix: treat meson as an *upper bound* only; keep explicit per-driver platform
claims. Do not assert support from absence of exclusion.

### 2. Non-derivable rows silently deleted
`Usage doc` x38, `SR-IOV` x22 (also `Design doc`, `Perf doc`).
These are the script's `UNCHECKED` set =E2=80=94 no code equivalent exists.
Pure information loss. **They need a home.** (Open question below.)

### 3. Partial support flattened: P -> Y, 160 times
Generator cannot express partial support:
`eth` P->Y x19, `vlan` P->Y x14, `Speed capabilities` P->Y x13,
`L4 checksum offload` P->Y x11.

`RULES` already models requirement groups and `support()` already computes
partial (some-but-not-all groups matched) =E2=80=94 **generation just disca=
rds it.**
Fix: propagate P instead of flattening. Verified real case: igb `eth =3D P`=
 is
correct and the generator would clobber it to `Y`.

## Open questions for the user

1. **Where do non-derivable facts live?** (`Usage doc`, `Design doc`,
   `Perf doc`, `SR-IOV`, tested-platform claims.) Options: small per-driver
   override file; annotation in driver source; or drop those rows entirely.
2. **Scope across the other 7 device classes** =E2=80=94 nics-only generati=
on leaves
   two mechanisms in `conf.py`.

## Also deferred: DRIVERS[] table is brittle (user-flagged)

Hardcoded ini-name -> source-path map in the script.
- `driver_for()` falls back to `(name, 'intel/'+name)` =E2=80=94 only ONE v=
endor dir is
  special-cased. A new vendor subdir, or a driver moving into one, **silent=
ly
  stops being checked**: no error, just no coverage. Worst failure mode for=
 a
  linter. `ipn3ke` only works today via that fallback (`intel/ipn3ke`).
- `all_dirs()` hardcodes the same `intel` special case.
- 24/27 entries exist only to disambiguate PF/VF sharing one directory.

Idea: derive the directory from meson/driver registration and recurse vendor
subdirs generically; keep `DRIVERS[]` only for genuine PF/VF ops-regex case=
s.
**If the table becomes generated documentation rather than a lint heuristic,
this must be solid first.**

## Verified facts worth not re-deriving

- `Code.__init__` walks the **whole** driver dir and concatenates all `.c`/=
`.h`,
  so multi-file drivers are handled by default. Blind spot is only the 9
  `DRIVERS[]` entries that narrow the *file set* via `files=3D`
  (e1000, igb, igb_vf, igc, enetc, enetc4, enetc4_vf, ice, ice_dcf).
  The other entries use `ops=3D` only, which still reads every file.
- **Rule adopted:** before deleting a doc row, grep the whole driver direct=
ory
  for the symbol, not just the globbed subset. If it exists outside the glob
  it is a script bug (defer); if absent everywhere the row is genuinely wro=
ng.
- e1000/igb rte_flow was NOT a script bug: `flow_ops_get` and all 7 flow it=
ems
  exist only in igb (`igb_flow.c`); em has none. Rows were in the wrong fil=
e.
  The *shared* header `e1000_ethdev.h` declaring `eth_igb_tx_done_cleanup` =
is
  why e1000 wrongly claimed "Free Tx mbuf on demand" =E2=80=94 multi-file l=
ayout was
  the *cause* of the doc errors, not an obstacle to finding them.

## Commit conventions (verified against DPDK's own checkers)

Always run: `./devtools/check-git-log.sh -nN && ./devtools/checkpatches.sh =
-nN`
- A title containing "fix" **requires** a `Fixes:` tag or check-git-log fai=
ls.
  Generate with:
  `git log -1 --abbrev=3D12 --format=3D'Fixes: %h ("%s")' <sha>`
- Doc feature-matrix fixes in history also carry `Cc: stable@dpdk.org`.
- Avoiding the word "fix" (e.g. "doc/af_packet: update feature matrix") is
  legitimate when there is no single culprit commit to blame.
- Find the culprit for a doc row: `git log -S'<row text>' -- <ini path>`

## Work already committed on branch `doc` (9 patches, all checker-clean)

    7d85396ec1 net/af_packet: support reading device clock   <- real code f=
ix
    41f385c391 doc/af_packet: update feature matrix
    cffcad6ad2 doc: fix e1000 and igb feature matrix
    3718164550 doc/axgbe: update feature matrix
               doc/mana, doc/memif, doc/pcap, doc/octeon_ep, doc/vhost

Drivers now reporting zero findings: afpacket, e1000, igb, axgbe, mana, mem=
if,
pcap, octeon_ep, vhost.

Recommendation: **keep these.** The af_packet `read_clock` is a genuine code
fix, and the doc ones are correct under either design and shrink the eventu=
al
generated diff.

Uncommitted: nothing. A partial batch (ena, nfb, thunderx, enetfec, pfe,
ntnic, bnx2x) was deliberately **not** applied pending this redesign.

## Constraints from the user

- Drivers with no ini today (bonding, null, ring, softnic): **do not create=
 one.**
- Prefer updating docs over changing drivers; if both, one patch each.
- One patch per driver.
- First pass: fix what is clearly fixable, do not force ambiguous cases.


