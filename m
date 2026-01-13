Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC3D2F349
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 17:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20ABD402DE;
	Tue, 13 Jan 2026 18:37:03 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id C3352402D6
 for <dev@dpdk.org>; Tue, 13 Jan 2026 18:37:01 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so43483775e9.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 09:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768325821;
 x=1768930621; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNvQazC44YT1YHlkQkd8h8NBvGh6GDcAv/6N7BfAwqA=;
 b=XTJxB36xdInMAiYd4NZ5NPNHVFW+aRWtz4GN9kDsP6CtUHDq612Ivno2yLoJU26CyB
 sA9F0pvh/Q5DmwUp11UHSYE2um9fGJMH3Xj+zSt/DbLdwtGhUpN9tlUllHPolPmp4QXv
 xUxVUcQ+MQImCpH2tCSKuC29VcxLA6kZ5MXG6lXAsJUQqQhX8aUm3PHOjhDel7XJGupr
 5Ipd0R4buqe5npafIyrRCx6svZZxF2NgroRIbY74TIhSwMfrKApK6WtCnfIJyrcipNag
 FfK33AaPjPzx9RVu6ivfpz4uFuH7/o0j8uMBc49ym4wRCjbmA2i4IkXpMj1HkWfn8ncc
 5d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768325821; x=1768930621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vNvQazC44YT1YHlkQkd8h8NBvGh6GDcAv/6N7BfAwqA=;
 b=fod28gwWiiXNUrUy5oPlWCdcGmR0tnLyTtknwW4Xu3wbUJOLWsgb+TNGZvBsUph5vr
 2jlDyxsz0ggernM98vzDuH2thti9gV3cX2T/xh+swhNAAk0Htlq8XyAnGRVtOhfH4mbQ
 3lxgpu87+TJV9kckJOgCA2o8oINxtkabGsCILosw8DqvyeFoz1yhoYRPk9OC+6W5Xcom
 YFVEpsUN03kIwmcutz9/j+WA6MKBFR+tezNoEj7eDtC2C1JMHlVUx0G0Ev0ErNmwnI+S
 BXKnP4nRMmgM3AYgdhtH7oFQOh6LTcM1xztnB4IMinz9AHfdlryN0AkL2HoKVSDtGwuS
 2E1A==
X-Gm-Message-State: AOJu0YxqXS8NVb/wUbEpKgwcQUBlnZ12rtl5oP5Vi5vM0ahc/1oubqPF
 jzi921v50oKgzN64ZS+8xaVouFwj/eFk69mvbOGCvhjuJLRDBUtNGX73SCfoXkUC1fcDHlekUji
 kSWw5
X-Gm-Gg: AY/fxX48ErtegCq81zr0yUfj5XRvYsAqxAC2VJv75kUQJQn1uC4+2RjwFXzYoQjvZJt
 w+UbS8SD9cwNUBG2YndZqduWC3cKbxhkSfQpuoAU2dHo3kmdc5hrcbGLK9141dywpjQeC35W049
 HgFN1jJFn5lEFEgb7kM4+0jj7UOUNkHY9xPrmavy7WodRIzy8pvgsYBuMme/BlDY/10l1zy+Iza
 Sh+s77gmg5CA3oqxQv4B7mM0CavPqmSqYn2Phzk4xXC8mL0243sCYseAziPklKwl7Gro93/X6LV
 cXudF1IVqG3c0KEld0EF7jr+Uhp4RvwnDXzi0DfcmfkPYX/f+6Y02wT8y9VuM7xaBlaeTSg3MEz
 rUBkySscrcidBD7hFe0KUOj8qvs/OR03BLAT7QxN1akxjclhqtMsZXIKaul6pnsw7oNqWgqflG4
 G9vcUCKWk4rYP6Fhwoa8FSM/uKI55HiQHAHe2/QbgzCqP+yiJvshEH
X-Received: by 2002:a05:600c:6989:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-47ee306b1d0mr535155e9.0.1768325821129; 
 Tue, 13 Jan 2026 09:37:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee28144aasm2282595e9.11.2026.01.13.09.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 09:37:00 -0800 (PST)
Date: Tue, 13 Jan 2026 09:36:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Elena
 Agostini" <eagostini@nvidia.com>
Subject: Re: [PATCH 1/9] gpu/cuda: add NVIDIA GPU H100
Message-ID: <20260113093655.025c8242@phoenix.local>
In-Reply-To: <20250915144137.54858-1-getelson@nvidia.com>
References: <20250915144137.54858-1-getelson@nvidia.com>
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

On Mon, 15 Sep 2025 17:41:28 +0300
Gregory Etelson <getelson@nvidia.com> wrote:

> From: Elena Agostini <eagostini@nvidia.com>
>=20
> Add support for new NVIDIA GPU H100.
>=20
> Signed-off-by: Elena Agostini <eagostini@nvidia.com>
> ---

In addition to Thomas's comments. AI code review also identified some probl=
ems.
Please fix and resubmit.
(Feels fun using AI to review Nvidia patches)...


## DPDK Patch Review: gpu/cuda NVIDIA GPU Device ID Series

**Series:** [PATCH 1/9] to [PATCH 9/9] - Adding NVIDIA GPU device IDs to CU=
DA driver =20
**Submitter:** Gregory Etelson (on behalf of Elena Agostini) =20
**Date:** Mon, 15 Sep 2025

---

### Overall Assessment

This series adds various NVIDIA GPU device IDs to the CUDA driver. While th=
e technical changes are straightforward, there are several compliance issue=
s with DPDK contribution guidelines.

---

### Patch-by-Patch Review

#### **Patch 1/9: `gpu/cuda: add NVIDIA GPU H100`**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 31 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| Component prefix | =E2=9C=85 Pass | `gpu/cuda:` correct |
| Signed-off-by | =E2=9C=85 Pass | Elena Agostini <eagostini@nvidia.com> |
| Commit body | =E2=9A=A0=EF=B8=8F Warning | Very minimal - "Add support fo=
r new NVIDIA GPU H100." |

**Verdict:** Acceptable, but body could be more descriptive.

---

#### **Patch 2/9: `gpu/cuda: new RoyB A100T GPU ID`**

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 33 characters |
| Subject style | =E2=9A=A0=EF=B8=8F Warning | "RoyB" - internal codename m=
ay not be meaningful to readers |
| **Commit body** | =E2=9D=8C **Error** | **Missing description - only Sign=
ed-off-by present** |
| Signed-off-by | =E2=9C=85 Pass | |

**Error (must fix):** Per AGENTS.md line 114: "Describe the issue being fix=
ed or feature being added." This patch has no body text.

---

#### **Patch 3/9:** (inferred from context - adds more device IDs)

Similar pattern to other patches.

---

#### **Patch 4/9: `gpu/cuda: new Hopper GPU IDs`**

| Check | Status | Notes |
|-------|--------|-------|
| Subject | =E2=9C=85 Pass | 27 characters |
| Commit body | =E2=9A=A0=EF=B8=8F Warning | Grammar: "Add **a** new NVIDIA=
 Hopper GPU **IDs**" - article/noun disagreement |
| Signed-off-by | =E2=9C=85 Pass | |

**Warning:** Should read either "Add new NVIDIA Hopper GPU IDs" or "Add a n=
ew NVIDIA Hopper GPU ID."

---

#### **Patch 5/9: `gpu/cuda: add new gpu hopper 80gb device id`**

| Check | Status | Notes |
|-------|--------|-------|
| Subject length | =E2=9C=85 Pass | 47 characters |
| **Subject case** | =E2=9A=A0=EF=B8=8F **Warning** | "gpu" and "hopper" sh=
ould likely be uppercase for consistency: "GPU" and "Hopper" |
| **Commit body mood** | =E2=9A=A0=EF=B8=8F **Warning** | "Added the new...=
" uses past tense. Should be imperative: "Add the new..." |
| Signed-off-by | =E2=9C=85 Pass | |

**Warning (should fix):** Per AGENTS.md line 54: Mood should be "Imperative=
 (instructions to codebase)."

---

#### **Patch 6/9:** (extends device IDs with A800, H800, L40, L4 series)

Major refactoring patch adding many device IDs. Code appears structurally s=
ound.

---

#### **Patch 7/9: `gpu/cuda: extend NVIDIA GPU device ID list`**

| Check | Status | Notes |
|-------|--------|-------|
| Subject | =E2=9C=85 Pass | 44 characters |
| **Signed-off-by** | =E2=9D=8C **Error** | `Signed-off-by: eagostini <eago=
stini@nvidia.com>` - **uses username, not real name** |
| From: line | =E2=9D=8C **Error** | `From: eagostini <eagostini@nvidia.com=
>` - same issue |

**Error (must fix):** Per AGENTS.md line 116: "Signed-off-by: present with =
**real name** and valid email" and line 168: "Tag format: Tag-name: **Full =
Name** <email@domain.com>."=20

Should be: `Signed-off-by: Elena Agostini <eagostini@nvidia.com>`

---

#### **Patch 8/9: `gpu/cuda: extend NVIDIA GPU device ID list`**

| Check | Status | Notes |
|-------|--------|-------|
| **Subject** | =E2=9A=A0=EF=B8=8F **Warning** | **Identical to Patch 7/9**=
 - subjects should be unique/descriptive |
| **Signed-off-by** | =E2=9D=8C **Error** | Same issue: `eagostini` instead=
 of `Elena Agostini` |
| From: line | =E2=9D=8C **Error** | Same issue |

**Warning:** Patches 7 and 8 have identical subjects. Per the spirit of AGE=
NTS.md guidelines, subjects should meaningfully distinguish patches. Consid=
er: "gpu/cuda: add Laptop and Embedded GPU IDs" for patch 8.

---

#### **Patch 9/9:** (extends list further with more Laptop/Embedded variant=
s)

Similar issues to patches 7/8 regarding authorship formatting.

---

### Code Style Issues

#### **1. Duplicate Macro Values (Patch 5)**

```c
#define NVIDIA_GPU_HOPPER_GRACE (0x2342)
#define NVIDIA_GPU_H100_GH1_DEVICE_ID (0x2342)
```

Two different macros defined with the same PCI device ID `0x2342`. This app=
ears intentional (same device, different names), but the `NVIDIA_GPU_HOPPER=
_GRACE` macro is later removed. The series should be consolidated to avoid =
this intermediate state breaking bisectability.

#### **2. Inconsistent Naming Convention**

The macro naming is inconsistent across the series:
- Some use `NVIDIA_GPU_*_DEVICE_ID` suffix
- Some use just `NVIDIA_*` (e.g., `NVIDIA_A40`, `NVIDIA_H100`) =20
- Some use `NVIDIA_RTX_*`

While not strictly an error, this inconsistency makes the code harder to ma=
intain.

#### **3. Double Blank Lines (Patch 9)**

```c
+	},
+
+
+	{
```

Lines 2130-2131 show two consecutive blank lines, which violates typical fo=
rmatting expectations.

#### **4. Missing Documentation Update**

Per AGENTS.md lines 646-650 and 658:
- "New drivers or subsystems must have release notes"
- "Update release notes in doc/guides/rel_notes/ for important changes"

Adding significant new GPU support (H100, H200, L40 series, etc.) should ar=
guably have a release notes entry, though this is borderline for device ID =
additions.

---

### Summary of Required Fixes

| Severity | Issue | Patches Affected |
|----------|-------|------------------|
| **Error** | Missing commit body | 2/9 |
| **Error** | Signed-off-by uses alias, not real name | 7/9, 8/9, 9/9 |
| **Error** | From: uses alias, not real name | 7/9, 8/9, 9/9 |
| Warning | Past tense in commit body | 5/9 |
| Warning | Lowercase in subject where uppercase expected | 5/9 |
| Warning | Grammar error in body | 4/9 |
| Warning | Duplicate subject lines | 7/9 vs 8/9 |
| Warning | Double blank lines in code | 9/9 |
| Info | Inconsistent macro naming style | Multiple |
| Info | Consider release notes update | Series |

---

### Recommended Actions

1. **Patch 2/9:** Add a description to the commit body explaining what "Roy=
B A100T" refers to.

2. **Patches 7/9, 8/9, 9/9:** Change author and signoff from:
   ```
   From: eagostini <eagostini@nvidia.com>
   Signed-off-by: eagostini <eagostini@nvidia.com>
   ```
   To:
   ```
   From: Elena Agostini <eagostini@nvidia.com>
   Signed-off-by: Elena Agostini <eagostini@nvidia.com>
   ```

3. **Patch 5/9:** Fix subject case and body tense:
   - Subject: `gpu/cuda: add new GPU Hopper 80GB device ID`
   - Body: "Add the new Hopper 80GB GPU device ID to the list."

4. **Patches 7 & 8:** Differentiate the subjects (e.g., one for datacenter =
GPUs, one for Laptop/Embedded).

5. **Patch 9:** Remove the double blank line in cuda.c.
