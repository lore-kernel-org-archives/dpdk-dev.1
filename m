Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A8D39008
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 19:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE1F440689;
	Wed, 14 Jan 2026 20:24:45 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id B8B4C4027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 20:24:43 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b870732cce2so32424866b.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768418683;
 x=1769023483; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyf2a3VfPe5khfLBCmZgi4w6ihkw5UiBoWqi308Hfnw=;
 b=ftPDqK+2ykoQMyx8nYVTe650E8VLFME8o0MDX3pnPwmX6IiN1ANV4QMA/wWawQYJra
 hVy1TBwfK9Stfuz5Qgeo4LwSPxmHtaUcTksu3LqYFm0/pBhBPHL2H42AuyO8JlqVy11k
 jhs2xrYC2FdxmPVFRsMDpu1F7qN3yh9dZah5pdilX1YG9D5fnWlXgetZFwrUUfMcmO6c
 tmoonBXSKVpl5clYoMC+uGBim4aCjCrkAgl2v4qKkt9iGsB7sUwLWHphvPz29LVglfRx
 pbQC+1dGM1GicHUM4sy8JiK0la1pxtWj5dOULll14PR4t2/TDidWRLSHLmPtwCMrqLlJ
 7Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768418683; x=1769023483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fyf2a3VfPe5khfLBCmZgi4w6ihkw5UiBoWqi308Hfnw=;
 b=Hz98mzi1EQaluNKzAB5Az6HJLD4QpJ82J75oxUIvzROMM13wI0AjwW39AbrfEhDuh2
 rSu2AN0/QHYOWpoYOXYxPBa4Zaf4l1JOr989E+amVVtt3MrX0Xdpf6p/+k31eHVsorge
 Y+fN0/XRI8pL6/icSn5XVFjkvCu7UKKRIdVy8vy0N1mD97oveDcvxEF47QSCaPhcsQnX
 vC8ci9aBdREVZ0ugJwDGuMQSusrpXNv9saNrTR8nnZCLUGe849itbYwO7vsiBJifSic6
 Fwuf5qAEcvADnqHqiuEldxSWl/8bUVS+7lwd2LGPYlTnPY+UewH75ztKNNP4TJIparI0
 ZwuA==
X-Gm-Message-State: AOJu0Yzh+riHBzgOe4F+p4TOY5NMY2ybSGB6RMaSzUW9ABfnrodc1fTF
 T4u5Ww6Z5rmp9Qf7yPD9HrOZPACZtbZ2RPmEuv8QpnJU/oA1nOU+9VjmV1wvnB14hr0=
X-Gm-Gg: AY/fxX72sJ27BoLtR73+Wzy7xYQVtqGfDHtyclsL5zOzjlT71uWUeQxpikN9c31UOX3
 RScfJr1xFBMS/q7dVPoXNaaO3uB2+dMEPWo7jgqNbCEQTXlbWj0W1A0mGvQJq5simBlycSU2uX8
 /AKw5DVO4Xv3TcmvAuiAIab5G0vWGZLxGPie8vZdyATzcUzuMcrOGYJmfuSEh8YB1LoBMYcF9Hn
 jkmce+rQu8/44SmYpdfXfcx0lvyfVQdFtlANR6RP6cPYhE2oPES1LGBSC2Ud/WIdyeFvoiy2bpS
 88PgJFO0BlIjcmNCa9A281AZV471kbN9kKmAvfo/f4iVgNwCc1VcLlTAWznSR0kHrmxFDjAQoID
 fYpsCkB17O5OlE3D5aJHMbg5UCobOk3vd1eZpEaJSVtARl7eh+ef7qzbXQA6gSnRpiP+g6swlNh
 U9tWLBawMOkrqfWkeymhjoHN4w3zbwqKKoA7UJKtQrHYuCeAFtw3oz
X-Received: by 2002:a17:907:3f8e:b0:b86:ff83:9e98 with SMTP id
 a640c23a62f3a-b8761073166mr327125566b.28.1768418682873; 
 Wed, 14 Jan 2026 11:24:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87023a8a33sm1181048266b.18.2026.01.14.11.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:24:42 -0800 (PST)
Date: Wed, 14 Jan 2026 11:24:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/2] Rewrite devbind
Message-ID: <20260114112437.465ec1e8@phoenix.local>
In-Reply-To: <cover.1733305654.git.anatoly.burakov@intel.com>
References: <cover.1733151400.git.anatoly.burakov@intel.com>
 <cover.1733305654.git.anatoly.burakov@intel.com>
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

On Wed,  4 Dec 2024 09:47:36 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> It has been suggested [1] that a major cleanup/rewrite of devbind would be
> beneficial in terms of long term maintainability of the code. I was in a
> coding mood over the weekend, and so I've went ahead and rewritten devbin=
d.
>=20
> Note that this is one giant patch, rather than a series of patches adjust=
ing
> existing code. Making it a patch series is possible, however the internal
> code architecture diverges quite significantly from the original devbind
> script due to its copious usage of string operations/pattern matching and
> global variables, so it is unclear whether subdividing this patch would be
> worth the effort. Instead, as has been suggested [2], the patchset now
> consists of creating a new file, followed by a removal of old file and
> rename of the new file. It is expected that this will be squashed on appl=
y.
>=20
> The script has become slightly bigger - 1000 lines instead of 800, however
> I would argue that since most of that increase is infrastructure, comment=
s,
> and sacrificing code golf for code readability (such as expanding one-lin=
ers
> into multiple lines), the trade-off between being able to read and reason
> about what happens in the script is worth the added line count.
>=20
> [1] https://patches.dpdk.org/project/dpdk/patch/c2bf00195c2d43833a831a9cc=
9346b4606d6ea2e.1723810613.git.anatoly.burakov@intel.com/
> [2] https://patches.dpdk.org/project/dpdk/cover/cover.1733151400.git.anat=
oly.burakov@intel.com/
>=20
> Anatoly Burakov (2):
>   usertools/devbind: update coding style
>   usertools/devbind: replace devbind
>=20
>  doc/guides/tools/devbind.rst |   11 +
>  usertools/dpdk-devbind.py    | 1683 ++++++++++++++++++----------------
>  2 files changed, 924 insertions(+), 770 deletions(-)
>=20

This patch seemed to get no reviews. So sent it to AI; especially since my =
python-fu is rudimentary.
It identified some small things, could you fix those and resubmit.

# DPDK Patch Review: usertools/devbind rewrite

**Series**: [PATCH v3 1/2] usertools/devbind: update coding style =20
**Author**: Anatoly Burakov <anatoly.burakov@intel.com> =20
**Reviewer**: Stephen Hemminger <stephen@networkplumber.org>

---

## Overview

This is a 2-patch series providing a complete rewrite of `dpdk-devbind.py`:

1. **Patch 1/2**: Introduces the new rewritten script as `dpdk-devbind-new.=
py`
2. **Patch 2/2**: Replaces the original script with the rewritten version

The rewrite brings significant improvements including PEP-484 type hints, m=
odern Python idioms with context managers, structured classes, JSON parsing=
 for `ip route` output, and deprecation of kernel <3.15 support.

---

## Errors (Must Fix)

### 1. Tag Formatting Error (Patch 1)
**Line 96:**
```
Reviewed-By: Stephen Hemminger <stephen@networkplumber.org>
```
Should be:
```
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
```
The `By` should be lowercase. DPDK tag format is `Reviewed-by:`.

### 2. Typo in Variable Name
**Line 325:**
```python
BASEDBAND_DEVICES =3D [CLASS_ACCELERATION]
```
Should be:
```python
BASEBAND_DEVICES =3D [CLASS_ACCELERATION]
```
This typo is referenced at line 369 as well.

### 3. Typo in Error Message =20
**Line 820:**
```python
raise DevbindError(f"CLeanup failed for {dev}: {e}") from e
```
Should be:
```python
raise DevbindError(f"Cleanup failed for {dev}: {e}") from e
```

---

## Warnings (Should Fix)

### 4. Docstring Inconsistency
**Line 452-453:**
```python
def read_output(args: T.List[str]) -> str:
    """Run a subprocess, collect its output, and return it as a list of lin=
es."""
```
The docstring says "list of lines" but the function returns a `str`. Either=
 update the docstring to say "return it as a string" or change the return t=
ype.

### 5. `--noiommu-mode` Flag Not Checked
**Lines 876-877:**
```python
if use_vfio and not sysfs_iommu_enabled():
    sysfs_enable_unsafe_noiommu()
```
The `ctx.noiommu` flag is parsed (line 1100) but the code unconditionally e=
nables no-IOMMU mode when IOMMU is disabled, regardless of whether the user=
 specified `--noiommu-mode`. The original devbind required the flag to be e=
xplicitly set. Consider:
```python
if use_vfio and not sysfs_iommu_enabled():
    if not ctx.noiommu:
        raise DevbindError(
            "IOMMU not available. Use --noiommu-mode to enable unsafe no-IO=
MMU mode."
        )
    sysfs_enable_unsafe_noiommu()
```

### 6. No Unit Tests Added
A rewrite of this magnitude would benefit from unit tests in `app/test` or =
at minimum a standalone test script. Consider adding tests for:
- Device pattern matching
- lspci line parsing
- Argument parsing edge cases

### 7. Patch 2/2 Missing Commit Message Body
**Line 1213:**
The second patch has only `Signed-off-by:` with no commit message body expl=
aining what it does. Even simple patches should have a brief description.

---

## Info (Suggestions)

### 8. File Mode for Bind Operation
**Line 807:**
```python
with open(bind_path, "a", encoding=3D"utf-8") as f:
    f.write(dev.slot)
```
Using append mode (`"a"`) for writing to sysfs bind file is unusual. While =
it likely works, write mode (`"w"`) is more conventional and matches what t=
he kernel expects. Consider changing to `"w"`.

### 9. Null Byte for driver_override Cleanup
**Line 818:**
```python
f.write("\00")
```
Writing a null byte works, but an empty string or newline might be more por=
table/conventional:
```python
f.write("")
```

### 10. Generator Consumed Multiple Times Risk
**Line 862:**
```python
devices =3D (devbind.pci_devices[dbdf] for dbdf in ctx.devices)
```
This creates a generator that can only be iterated once. If the code path w=
ere to iterate it multiple times, this would silently fail. Consider using =
a list comprehension instead:
```python
devices =3D [devbind.pci_devices[dbdf] for dbdf in ctx.devices]
```

### 11. Consider Using `shutil.which()` Instead of `subprocess`
**Lines 446-449:**
```python
if subprocess.call(
    ["which", program], stdout=3Dsubprocess.DEVNULL, stderr=3Dsubprocess.DE=
VNULL
):
```
Python 3.3+ provides `shutil.which()` which is more Pythonic:
```python
import shutil
if shutil.which(program) is None:
```

### 12. Documentation Formatting
**Lines 129-138 in doc/guides/tools/devbind.rst:**
The added documentation has a double blank line after line 128. RST typical=
ly uses single blank lines.

---

## Positive Observations

The rewrite demonstrates excellent software engineering:

- **Type Safety**: Comprehensive PEP-484 type annotations throughout
- **Modern Python**: Context managers, dataclasses pattern, proper exceptio=
n hierarchy
- **Code Organization**: Clean separation with `Device`, `Devbind`, and `De=
vbindCtx` classes
- **Error Handling**: Consistent `DevbindError` exception with clear messag=
es
- **Resource Management**: All file operations use context managers
- **JSON Parsing**: Using `ip -j route` for structured output is much bette=
r than text parsing
- **Reduced External Calls**: Fewer lspci invocations, unified parsing
- **Backward Compatibility**: Command-line interface remains compatible

---

## Summary

| Severity | Count |
|----------|-------|
| Error    | 3     |
| Warning  | 4     |
| Info     | 5     |

**Recommendation**: Fix the three errors (tag case, two typos) and address =
the `--noiommu-mode` logic, then this is ready for merge. The rewrite is a =
significant improvement over the original code.

---

## Checklist

- [x] SPDX license identifier present
- [x] Copyright line present =20
- [x] Signed-off-by present
- [ ] Reviewed-by tag correctly formatted
- [x] Subject line =E2=89=A460 characters
- [x] Subject lowercase (except acronyms)
- [x] Imperative mood
- [x] No trailing period
- [x] Lines =E2=89=A4100 characters (Python allows this)
- [x] Documentation updated
- [ ] Tests added/updated

