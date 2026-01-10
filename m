Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B225FD277F3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 17:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0610240E1B;
	Sat, 10 Jan 2026 18:34:15 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 7D1A54028E
 for <dev@dpdk.org>; Sat, 10 Jan 2026 18:34:13 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso20483755e9.1
 for <dev@dpdk.org>; Sat, 10 Jan 2026 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768066453;
 x=1768671253; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILno9y/XTeANyj2ZUooc9kJ6SImz6rqLhvngy3mv1YA=;
 b=JtIT9TkSPZ+t0+HDnU++rfHC1S3GrazdZnxegIvfyTsl10Cm4ldhNB84lne4bZHBDG
 IgvSSwtEs9Eo5YvAYFT96dpcTxf+P/DCJcNHdhZtUkPVkghXe2nM98f0uPhebzLvSL7O
 ABhv1VNoBUZ5tm0UkdmTvr/nf0lT+PbjK2KIeOXME31Wi94O1L4jJXJMGL1X5oyFP7E5
 FbZtb2VLWqtbEnuSeMUHy0+RfetMG9Ga6DkeavZn2y1xRefoxOHLiNHZJDbOHJRD6z3I
 I2GVJsUN7VRG7Ig5qPM4Ln398m/Q+J+qFR1GbwRu0Hf00Ne2MJ6pC4o+rDWut/bhcvsp
 UxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768066453; x=1768671253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ILno9y/XTeANyj2ZUooc9kJ6SImz6rqLhvngy3mv1YA=;
 b=w1vAhsFdzd9JL6rwDLfruA8IjwV/UwaZPKY/JVxrYNXrtk9GGUkulrpBpalGFAQTMD
 cPyda4Yl7S0DBi2wEmNQid60WPlRspUcMCGeU4sJkLZ5chQX7zCitIfpZfJo67hvkm5H
 2Fcibvdk5kxUN4+nBoE68ave/rtBDgHUx7zx7zH1l6qHn06g7HZols5j0/XMAMxFjDOp
 W0YlwgPfvj4dN+cFSftjqeB3Lvgay6jv2c1/wjqvSRcKoMNFNz52HHtsSJnywXCb0iBR
 cS8qFPYE4f5Cs/GVp9bb8rTlAzILWgMAjjeQxi52ee+m0sNCry5K6KfBWZr3vsfo+wcQ
 rWtw==
X-Gm-Message-State: AOJu0YxtpzOcGPMeoyR/EUnS5g5IpO8bfS91dv7uUkxMyOrkuMyq++Yi
 OHtmyvo64sXbaWPo9lrV5WUMh4K6RLZur/QIijVpQmPYfpep/ilPq1tOfQ8MzXdfPyzd638IXlP
 LSVGT
X-Gm-Gg: AY/fxX69amMa2ffCgPfrx7zuvvmE3AkPYWU/6Pqs9hk25x4WgVG1Rr1GkylQViMFjSS
 TURWPiO9Nlaur23AVRtAvonisU+/kiBI0Tha4VHP1NCpX53uyeQzqFDtlfFYbNpsyH+t4oZBpY4
 yev9ec8c4BzlV8EY2kXge7kLYQBYi3AKcf+lz8m+AgcBkamygtYEPTJgB9hwhleUnr49njR3ASU
 1GCBonamuIlAhTaNoOlVTspO4xyELJjXk3YQ0nQ1BodVxsP3A4JTr4Wr4iEtUDu9di/QdUWBfS5
 nADMVdZ5B0E8sp0ULdgTZ09nv56gM8H9RiVV5hNT8lnHTHcIh6VvnRV8ML0jGZXaprJDcId/MTM
 bHzPtJf0YHaRf7SbrgzD1Xj8x9fAcvaXLkQWOvwYNxAVAqtX3q2XzYmvgPe34DRA1eDll+FYKyq
 QVlaBfyU6ovhay1XVjYfyRmyqJ+96835nLBAaae7xkB91/lNA//+Tb
X-Google-Smtp-Source: AGHT+IFS9MGCeuknsZvO9VevNhoYPQAl1Y11YJWGOJZqLQaF31z0DPDQpStiiO+5dKJeeJqrgYjCWg==
X-Received: by 2002:a05:600c:1792:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-47d7f6163f8mr139122505e9.10.1768066452946; 
 Sat, 10 Jan 2026 09:34:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa07sm28699908f8f.25.2026.01.10.09.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 09:34:12 -0800 (PST)
Date: Sat, 10 Jan 2026 09:34:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC] doc: add AGENTS.md for AI-powered code review tools
Message-ID: <20260110093408.1071aa19@phoenix.local>
In-Reply-To: <aWDOWEI4NuzrfP2D@bricha3-mobl1.ger.corp.intel.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <aWDOWEI4NuzrfP2D@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 9 Jan 2026 09:46:00 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Thu, Jan 08, 2026 at 05:41:04PM -0800, Stephen Hemminger wrote:
> > Add a structured reference document that enables AI code review tools
> > to validate DPDK contributions against project standards. This document
> > consolidates requirements from multiple sources into a machine-readable
> > format optimized for automated validation workflows.
> >=20
> > The AGENTS.md file synthesizes guidelines from:
> > - DPDK Contributing Code documentation (patches.rst)
> > - DPDK Coding Style guidelines (coding_style.rst)
> > - Linux kernel patch submission process (submitting-patches.rst)
> > - SPDX License Identifier specification (spdx.org)
> >=20
> > Key sections include:
> > - SPDX license identifier requirements
> > - Commit message format and tag ordering
> > - C coding style rules and naming conventions
> > - Patch validation checklists with severity levels
> > - Meson build file style requirements
> >=20
> > The document provides actionable checklists and concrete examples to
> > support integration with CI/CD pipelines and automated review systems.
> > Severity levels (error/warning/info) help tools prioritize feedback
> > appropriately.
> >=20
> > This supports the broader goal of maintaining code quality and
> > consistency as the project scales, while reducing manual review burden
> > for maintainers on mechanical style issues.
> >=20
> > References:
> > - https://doc.dpdk.org/guides/contributing/patches.html
> > - https://doc.dpdk.org/guides/contributing/coding_style.html
> > - https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> > - https://spdx.org/licenses/
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > --- =20
>=20
> Good to see this being added.
>=20
> Feedback inline below.
>=20
> Thanks,
> /Bruce
>=20
> >  AGENTS.md | 410 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 410 insertions(+)
> >  create mode 100644 AGENTS.md
> >=20
> > diff --git a/AGENTS.md b/AGENTS.md
> > new file mode 100644
> > index 0000000000..cfaaa81af3
> > --- /dev/null
> > +++ b/AGENTS.md
> > @@ -0,0 +1,410 @@
> > +# AGENTS.md - DPDK Code Review Guidelines for AI Tools
> > +
> > +This document provides guidelines for AI-powered code review tools whe=
n reviewing contributions to the Data Plane Development Kit (DPDK). It is d=
erived from the official DPDK contributor guidelines.
> > +
> > +## Overview
> > +
> > +DPDK follows a development process modeled on the Linux Kernel. All pa=
tches are reviewed publicly on the mailing list before being merged. AI rev=
iew tools should verify compliance with the standards outlined below.
> > +
> > +---
> > +
> > +## Source License Requirements
> > +
> > +### SPDX License Identifiers
> > +
> > +- **Every file must begin with an SPDX license identifier** on the fir=
st line (or second line for `#!` scripts)
> > +- Core libraries and drivers use `BSD-3-Clause`
> > +- Kernel components use `GPL-2.0`
> > +- Dual-licensed code uses: `(BSD-3-Clause OR GPL-2.0)`
> > +
> > +```c
> > +/* Correct */
> > +/* SPDX-License-Identifier: BSD-3-Clause */
> > +
> > +/* Incorrect - no boilerplate license text should follow */
> > +```
> > +
> > +- A blank line must follow the license header before any other content
> > + =20
>=20
> Not strictly true, the blank line follows the copyright line immediately
> after the SPDX header. The copyright line should be included in
> descriptions and examples above.

I think that was something Linux kernel wanted.

>=20
> > +---
> > +
> > +## Commit Message Requirements
> > +
> > +### Subject Line (First Line)
> > +
> > +- **Must capture the area and impact** of the change
> > +- **~50 characters** recommended length =20
>=20
> In practice I think we allow up to 60 chars. So 50 chars recommended, 60
> char max.
>=20
> > +- **Lowercase** except for acronyms
> > +- **Prefixed with component name** (check `git log` for existing compo=
nents)
> > +- Use **imperative mood** (instructions to the codebase)
> > +- **No trailing period** (causes double periods in patch filenames)
> > +
> > +```
> > +# Good examples
> > +ixgbe: fix offload config option name =20
>=20
> Should be "net/ixgbe".
> Since you have a driver example below, I'd suggest picking an example for=
 a
> library e.g. hash, to include as well.

I suspect AI got this from old examples.

>=20
> > +config: increase max queues per port
> > +net/mlx5: add support for flow counters
> > +
> > +# Bad examples
> > +Fixed the offload config option.    # past tense, has period
> > +IXGBE: Fix Offload Config           # uppercase
> > +```
> > +
> > +### Commit Body
> > +
> > +- Describe the issue being fixed or feature being added
> > +- Provide enough context for reviewers to understand the purpose
> > +- Wrap text at **72 characters**
> > +- **Must end with** `Signed-off-by:` line (real name, not alias)
> > +- When fixing regressions, include:
> > +  ```
> > +  Fixes: abcdefgh1234 ("original commit subject")
> > +  Cc: original_author@example.com
> > +  ``` =20
>=20
> I know we *should* CC original authors, but in practice I don't think we
> do. So many original authors have moved on, I suspect that this guidance
> just causes too many email bounces to be useful. I would update this to
> Fixes and CC stable for all fixes. Let's not burden the contributor with
> determining if a patch needs backport or not - I assume the stable tree
> maintainers have tooling to pull out only relevant fixes for their trees.


Would prefer that get_maintainer script used instead.

> > +
> > +### Required Tags
> > +
> > +```
> > +# For Coverity issues:
> > +Coverity issue: 12345
> > +
> > +# For Bugzilla issues:
> > +Bugzilla ID: 12345
> > +
> > +# For stable release backport candidates:
> > +Cc: stable@dpdk.org =20
>=20
> I'd make this an always-add for bugfixes, unless it causes us other issue=
s.

Should be checkpatch rule?

> > +
> > +# For patch dependencies:
> > +Depends-on: series-NNNNN ("Title of the series")
> > +```
> > +
> > +### Tag Order
> > +
> > +```
> > +Coverity issue:
> > +Bugzilla ID:
> > +Fixes:
> > +Cc:
> > +
> > +Reported-by:
> > +Suggested-by:
> > +Signed-off-by:
> > +Acked-by:
> > +Reviewed-by:
> > +Tested-by:
> > +```
> > +
> > +Note: Empty line between the first group and `Reported-by:`
> > +
> > +---
> > +
> > +## C Coding Style
> > +
> > +### General Formatting
> > +
> > +- **Line length**: Recommended =E2=89=A480 characters, acceptable up t=
o 100 =20
>=20
> I'd drop the 80 reference. If we can use 100 chars, let's do so, rather
> than having lines split.
>=20
> > +- **Tab width**: 8 characters (hard tabs for indentation, spaces for a=
lignment)
> > +- **No trailing whitespace** on lines or at end of files
> > +- Code style must be consistent within each file
> > +
> > +### Comments
> > +
> > +```c
> > +/* Most single-line comments look like this. */
> > +
> > +/*
> > + * VERY important single-line comments look like this.
> > + */
> > +
> > +/*
> > + * Multi-line comments look like this. Make them real sentences. Fill
> > + * them so they look like real paragraphs.
> > + */
> > +```
> > +
> > +### Header File Organization
> > +
> > +Include order (each group separated by blank line):
> > +1. System/libc includes
> > +2. DPDK EAL includes
> > +3. DPDK misc library includes
> > +4. Application-specific includes
> > +
> > +```c
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include <rte_eal.h>
> > +
> > +#include <rte_ring.h>
> > +#include <rte_mempool.h>
> > +
> > +#include "application.h"
> > +```
> > +
> > +### Header Guards
> > +
> > +```c
> > +#ifndef _FILE_H_
> > +#define _FILE_H_
> > +
> > +/* Code */
> > +
> > +#endif /* _FILE_H_ */
> > +```
> > +
> > +### Naming Conventions
> > +
> > +- **All external symbols** must have `RTE_` or `rte_` prefix
> > +- **Macros**: ALL_UPPERCASE
> > +- **Functions**: lowercase with underscores only (no CamelCase)
> > +- **Variables**: lowercase with underscores only
> > +- **Enum values**: ALL_UPPERCASE with `RTE_<ENUM>_` prefix
> > +- **Struct types**: prefer `struct name` over typedefs
> > + =20
>=20
> We can strengthen and clarify this, I think: for new definitions, typedefs
> only for function pointer types.

Should also add exception for base type code.

+
> > +### Structure Layout
> > +
> > +- Order members by: use, then size (largest to smallest), then alphabe=
tically
> > +- New additions to existing structures go at the end (ABI compatibilit=
y)
> > +- Align member names with spaces =20
>=20
>=20
> Nice to have, ignored in practice AFAIK. Maybe not worth including.
>=20
> > +- Avoid `bool` in structures (unclear size, wastes space) =20
>=20
> Disagree on this one. Unless it's a datapath struct that must be small,
> using bool is a lot clearer and easier to manage than bit fields.

I think this was inherited from kernel style. Lots of bool flags when
bitfield could be used.

>=20
> > +
> > +```c
> > +struct foo {
> > +        struct foo      *next;          /* List of active foo. */
> > +        struct mumble   amumble;        /* Comment for mumble. */
> > +        int             bar;            /* Try to align the comments. =
*/
> > +};
> > +```
> > +
> > +---
> > +
> > +## Code Quality Requirements
> > +
> > +### Compilation
> > +
> > +- Each commit must compile independently (for `git bisect`)
> > +- No forward dependencies within a patchset
> > +- Test with multiple targets, compilers, and options
> > +- Use `devtools/test-meson-builds.sh`
> > +
> > +### Testing
> > +
> > +- Add tests to `app/test` unit test framework
> > +- New API functions must be used in `/app` test directory
> > +- New device APIs require at least one driver implementation
> > +
> > +### Documentation
> > +
> > +- Add Doxygen comments for public APIs
> > +- Update release notes in `doc/guides/rel_notes/` for important changes
> > +- Code and documentation must be updated atomically in same patch
> > +
> > +### ABI Compatibility
> > +
> > +- New external functions must be exported properly
> > +- Follow ABI policy and versioning guidelines
> > +- Enable ABI checks with `DPDK_ABI_REF_VERSION` environment variable
> > +
> > +---
> > +
> > +## Patch Validation Checklist
> > +
> > +AI review tools should verify:
> > +
> > +### Commit Message
> > +- [ ] Subject line ~50 chars, lowercase (except acronyms) =20
>=20
> 60 chars
>=20
> > +- [ ] Component prefix present and valid
> > +- [ ] Imperative mood used
> > +- [ ] No trailing period on subject
> > +- [ ] Body wrapped at 72 characters
> > +- [ ] `Signed-off-by:` present with real name
> > +- [ ] `Fixes:` tag present for bug fixes with 12-char SHA
> > +- [ ] Tags in correct order
> > +
> > +### License
> > +- [ ] SPDX identifier on first line (or second for scripts)
> > +- [ ] Appropriate license for file type
> > +- [ ] Blank line after license header
> > +
> > +### Code Style
> > +- [ ] Lines =E2=89=A4100 characters (prefer =E2=89=A480)
> > +- [ ] Hard tabs for indentation
> > +- [ ] No trailing whitespace
> > +- [ ] Proper include order
> > +- [ ] Header guards present
> > +- [ ] `rte_`/`RTE_` prefix on external symbols
> > +- [ ] No prohibited terminology
> > +- [ ] Proper brace style
> > +- [ ] Function return type on own line
> > +- [ ] NULL comparisons use `=3D=3D NULL` =20
>  - [ ] Integer comparisons use `=3D=3D 0`
>=20
> > +
> > +### Structure
> > +- [ ] Each commit compiles independently
> > +- [ ] Code and docs updated together
> > +- [ ] Tests added/updated as needed
> > +- [ ] Release notes updated for significant changes
> > +
> > +---
> > +
> > +## Meson Build Files
> > +
> > +### Style Requirements
> > +
> > +- 4-space indentation (no tabs)
> > +- Line continuations double-indented
> > +- Lists alphabetically ordered
> > +- Short lists (=E2=89=A43 items): single line, no trailing comma
> > +- Long lists: one item per line, trailing comma on last item
> > +
> > +```python
> > +# Short list
> > +sources =3D files('file1.c', 'file2.c')
> > +
> > +# Long list
> > +headers =3D files(
> > +        'header1.h',
> > +        'header2.h',
> > +        'header3.h',
> > +)
> > +```
> > +
> > +---
> > +
> > +## Python Code
> > +
> > +- Must comply with PEP8
> > +- Line length acceptable up to 100 characters
> > +- Use `pep8` tool for validation
> > + =20
>=20
> I think we are switching to using "black" as the python formatting tool of
> choice.
>=20
> > +---
> > +
> > +## Review Process Notes
> > +
> > +### For AI Review Tools
> > +
> > +When providing feedback:
> > +- Reference specific line numbers
> > +- Cite the relevant guideline section
> > +- Suggest concrete fixes
> > +- Prioritize: errors > warnings > style suggestions
> > +- Flag potential ABI breaks
> > +- Check for missing documentation updates
> > +- Verify test coverage for new functionality
> > +
> > +### Severity Levels
> > +
> > +**Error** (must fix):
> > +- Missing SPDX license
> > +- Missing Signed-off-by
> > +- Compilation failures
> > +- ABI breaks without proper versioning
> > +
> > +**Warning** (should fix):
> > +- Style violations
> > +- Missing Fixes tag for bug fixes
> > +- Documentation gaps
> > +- Missing tests
> > +
> > +**Info** (consider):
> > +- Minor style preferences
> > +- Optimization suggestions
> > +- Alternative approaches
> > --=20
> > 2.51.0
> >  =20

I will try and make a prompt to get a better result. Often good stuff
happens with better prompt rather than manual edits.

